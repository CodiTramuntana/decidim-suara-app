# frozen_string_literal: true

require "spec_helper"

# rubocop:disable Rspec/AnyInstance
module Decidim
  describe Decidim::Devise::OmniauthRegistrationsController, type: :controller do
    routes { Decidim::Core::Engine.routes }

    let(:organization) { create(:organization) }
    let(:sap_response) do
      {
        ceco: "ceco",
        ceco_txt: "ceco_txt",
        tipologia: "tipologia",
        grup_empleados: "grup_empleados",
        estat_soci: "estat_soci",
        derechovoto: "derechovoto",
        estat_ocup: "estat_ocup"
      }
    end

    before do
      request.env["decidim.current_organization"] = organization
      request.env["devise.mapping"] = ::Devise.mappings[:user]
      allow_any_instance_of(SapAuthorizationHandler).to receive(:metadata).and_return(sap_response)
    end

    describe "POST create" do
      let(:provider) { "google" }
      let(:uid) { "12345" }
      let(:email) { "best_user@from-google.com" }

      before do
        request.env["omniauth.auth"] = {
          provider: provider,
          uid: uid,
          info: {
            name: "Google User",
            email: email
          }
        }
      end

      context "when the unverified email address is already in use" do
        before do
          post :create
        end

        it "doesn't create a new user" do
          expect(User.count).to eq(1)
        end

        it "logs in" do
          expect(controller).to be_user_signed_in
        end
      end

      context "when the unverified email address is already in use but left unconfirmed" do
        let!(:user) { create(:user, organization: organization, email: email) }

        before do
          user.update!(
            confirmation_sent_at: Time.now.utc - 1.year
          )
        end

        context "with the same email as from the identity provider" do
          before do
            post :create
          end

          it "logs in" do
            expect(controller).to be_user_signed_in
          end

          it "confirms the user account" do
            expect(controller.current_user).to be_confirmed
          end
        end
      end
    end
  end
end
# rubocop:enable Rspec/AnyInstance
