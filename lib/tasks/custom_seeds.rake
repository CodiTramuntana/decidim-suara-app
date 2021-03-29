# frozen_string_literal: true

namespace :suara do
  namespace :custom_seeds do
    desc "Create N participants ready to login"
    task :users, [:number] => :environment do |_task, args|
      num_users= args.number.to_i
      puts "Creating #{num_users} users"

      org_id= 1
      org= Decidim::Organization.find(org_id)
      num_users.times do |idx|
        password= "suara123456789"
        user= Decidim::User.new(
          decidim_organization_id: org_id,
          admin: false,
          name: "Suara #{idx}",
          nickname: "suara_#{idx}",
          email: "suara-#{idx}@example.org",
          locale: "ca",
          password: password,
          password_confirmation: password,
          accepted_tos_version: org.tos_version,
          tos_agreement: true
        )
        user.skip_invitation= true
        user.skip_confirmation!
        user.save!
      end
    end
  end
end
