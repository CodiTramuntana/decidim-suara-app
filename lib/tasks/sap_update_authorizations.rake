# frozen_string_literal: true

namespace :sap do
  desc "Updates users metadata in authorizations by SAP"
  task update_metadata: :environment do
    puts "UpdateMetadata: ------------------- START #{Time.current}"

    users = Decidim::User.all
    users_count = users.size
    users.each_with_index do |user, index|
      puts "#{index}/#{users_count} - [#{user.id}] Metadata already updated"
      authorization = Decidim::AuthorizationHandler.handler_for(
        "sap_authorization_handler",
        user: user
      )
      Decidim::CreateSapAuthorization.call(authorization) do
        on(:ok) {}
        on(:invalid) {}
      end
    end

    puts "UpdateMetadata: -------------------  END #{Time.current}"
  end
end
