# frozen_string_literal: true

module Decidim
  module Devise
    # This controller customizes the behaviour of Devise::Omniauthable.
    class OmniauthRegistrationsController < ::Devise::OmniauthCallbacksController
      include FormFactory
      include Decidim::DeviseControllers

      def new
        @form = form(OmniauthRegistrationForm).from_params(params[:user])
      end

      def create
        form_params = user_params_from_oauth_hash || params[:user]

        @form = form(OmniauthRegistrationForm).from_params(form_params)
        @form.email ||= verified_email
        @form.nickname ||= verified_email.split("@").first.parameterize(separator: "_")

        CreateOmniauthRegistration.call(@form, verified_email) do
          on(:ok) do |user|
            if user.active_for_authentication?
              sign_in_and_redirect user, event: :authentication
              set_flash_message :notice, :success, kind: @form.provider.capitalize
              authorization = Decidim::AuthorizationHandler.handler_for(
                "sap_authorization_handler",
                user: user
              )

              CreateSapAuthorization.call(authorization)
            else
              expire_data_after_sign_in!
              user.resend_confirmation_instructions unless user.confirmed?
              redirect_to decidim.root_path
              flash[:notice] = t("devise.registrations.signed_up_but_unconfirmed")
            end
          end

          on(:invalid) do
            set_flash_message :notice, :success, kind: @form.provider.capitalize
            render :new
          end

          on(:error) do |user|
            if user.errors[:email]
              set_flash_message :alert, :failure, kind: @form.provider.capitalize, reason: t("decidim.devise.omniauth_registrations.create.email_already_exists")
            end

            render :new
          end
        end
      end

      def after_sign_in_path_for(user)
        if user.present? && user.blocked?
          check_user_block_status(user)
        elsif !pending_redirect?(user) && first_login_and_not_authorized?(user)
          decidim_verifications.authorizations_path
        else
          super
        end
      end

      # Calling the `stored_location_for` method removes the key, so in order
      # to check if there's any pending redirect after login I need to call
      # this method and use the value to set a pending redirect. This is the
      # only way to do this without checking the session directly.
      def pending_redirect?(user)
        store_location_for(user, stored_location_for(user))
      end

      def first_login_and_not_authorized?(user)
        user.is_a?(User) && user.sign_in_count == 1 && Decidim::Verifications.workflows.any? && user.verifiable?
      end

      def action_missing(action_name)
        return send(:create) if devise_mapping.omniauthable? && current_organization.enabled_omniauth_providers.keys.include?(action_name.to_sym)

        raise AbstractController::ActionNotFound, "The action '#{action_name}' could not be found for Decidim::Devise::OmniauthCallbacksController"
      end

      private

      def oauth_data
        @oauth_data ||= oauth_hash.slice(:provider, :uid, :info)
      end

      # Private: Create form params from omniauth hash
      # Since we are using trusted omniauth data we are generating a valid signature.
      def user_params_from_oauth_hash
        return nil if oauth_data.empty?

        {
          provider: oauth_data[:provider],
          uid: oauth_data[:uid],
          name: oauth_data[:info][:name],
          nickname: oauth_data[:info][:nickname],
          oauth_signature: OmniauthRegistrationForm.create_signature(oauth_data[:provider], oauth_data[:uid]),
          avatar_url: oauth_data[:info][:image],
          raw_data: oauth_hash
        }
      end

      def verified_email
        @verified_email ||= oauth_data.dig(:info, :email)
      end

      def oauth_hash
        raw_hash = request.env["omniauth.auth"]
        return {} unless raw_hash

        raw_hash.deep_symbolize_keys
      end
    end
  end
end
