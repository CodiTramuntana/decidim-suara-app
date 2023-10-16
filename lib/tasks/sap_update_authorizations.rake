# frozen_string_literal: true

namespace :sap do
  desc "Updates users metadata in authorizations by SAP"
  task update_metadata: :environment do
    Decidim::User.find_each do |user|
      authorization = Decidim::AuthorizationHandler.handler_for(
        "sap_authorization_handler",
        user: user
      )
      Decidim::CreateSapAuthorization.call(authorization) do
        on(:ok) do
          authorization= Decidim::Authorization.find_by(decidim_user_id: user.id, name: "sap_authorization_handler")
          Rails.logger.info "UpdateMetadata: --- INFO: USER #id: #{user.id} -> Authorization updated at: #{authorization.updated_at}"
        end
        on(:invalid) do
          Rails.logger.info "UpdateMetadata: --- INFO: authorization is invalid and can't be created for the user #id: #{user.id}."
        end
      end
    end
  end
end
