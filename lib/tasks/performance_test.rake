# frozen_string_literal: true

namespace :benchmark do
  desc "Data for performance tests"
  task create_example_data: :environment do
    1000.times do |index|
      email= "suara_#{index}@example.org"
      user = Decidim::User.new(email: email, password: "codit123456789", password_confirmation: "codit123456789", organization: Decidim::Organization.first, nickname: "suara_#{index}", name: "User tests", tos_agreement: true)
      user.skip_confirmation!
      user.save!

      puts "Created user #{index}"
      
      if index >= 10
        unique_id= Digest::MD5.hexdigest("#{email}-#{Rails.application.secrets.secret_key_base}")
        Decidim::Authorization.create(name: "sap_authorization_handler", user: user, metadata: { grup_empleados: "SOCIS" }, unique_id: unique_id, granted_at: Time.current)
        puts "Created authorization #{index}"
      end
    end
  end

  desc "Prints test delegations CSV to stdout"
  task delegations_csv: :environment do
    1000.times do |idx|
      next if idx%2 != 0

      granter= "suara_#{idx}@example.org"
      grantee= "suara_#{idx + 1}@example.org"
      puts "#{granter},#{grantee}"
    end
  end

  desc "loads delegations from CSV (same format as from admin panel"
  task load_delegations: :environment do
    current_setting= Decidim::ActionDelegator::OrganizationSettings.new(Decidim::Organization.first).query.find(9)

    current_user= Decidim::User.find_by(email: "support@coditramuntana.com")

    CSV.foreach("/home/coditramuntana/decidim_suara/current/tmp/delegations.csv", encoding: "UTF-8") do |granter_email, grantee_email|
      Decidim::ActionDelegator::ImportDelegationsCsvJob.perform_later(granter_email, grantee_email, current_user, current_setting) if granter_email.present? && grantee_email.present?
    end
  end

  desc "Prints test csv_emails CSV to stdout"
  task :csv_emails_csv do
    puts "email"
    1000.times do |idx|
      puts "suara_#{idx}@example.org"
    end
  end

  task :authorize_all_by_csv_email do
    1000.times do |idx|
      email= "suara_#{idx}@example.org"
      handler = Decidim::AuthorizationHandler.handler_for(
        "csv_email_authorization_handler",
        {email: email, user: Decidim::User.find_by(email: email)}
      )

      puts Decidim::Authorization.create_or_update_from(handler)
    end
  end
end





1000.times do |idx|
  next if idx < 10

  email= "suara_#{idx}@example.org"
  unique_id= Digest::MD5.hexdigest("#{email}-#{Rails.application.secrets.secret_key_base}")
  Decidim::Authorization.find_by(user: Decidim::User.find_by(email: email)).update_attribute(:unique_id, unique_id)
end









consultation = Decidim::Consultation.find_by(slug: "simulacre-votacio")
votes = Decidim::Consultations::Vote.joins(:question).where("decidim_consultations_questions.decidim_consultation_id": consultation.id)

