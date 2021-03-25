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
          Rails.logger.info "UpdateMetadata: --- INFO: USER with #id: #{user.id} doesn't have any metadata." if authorization.metadata.values.compact.empty?
        end
        on(:invalid) do
          Rails.logger.info "UpdateMetadata: --- INFO: authorization couldn't be created for the user #id: #{user.id}."
        end
      end
    end
  end
end
