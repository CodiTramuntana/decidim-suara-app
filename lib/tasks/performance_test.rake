# frozen_string_literal: true

namespace :performance_test do
  desc "Data for performance tests"
  task create_example_data: :environment do
    1000.times do |index|
      user = Decidim::User.new(email: "suara_#{index}@example.org", password: "codit123456789", password_confirmation: "codit123456789", organization: Decidim::Organization.first, nickname: "suara_#{index}", name: "User tests", tos_agreement: true)
      user.skip_confirmation!
      user.save!

      puts "Created user #{index}"
      
      if index >= 10
        Decidim::Authorization.create(name: "sap_authorization_handler", user: user, metadata: { grup_empleados: "SOCIS" })
        puts "Created authorization #{index}"
      end
    end
  end
end
