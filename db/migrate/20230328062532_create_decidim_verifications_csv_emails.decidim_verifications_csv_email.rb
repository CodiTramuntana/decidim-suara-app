# frozen_string_literal: true
# This migration comes from decidim_verifications_csv_email (originally 20181903170521)

class CreateDecidimVerificationsCsvEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :decidim_verifications_csv_email_csv_email_data do |t|
      t.references :decidim_organization, foreign_key: true, index: { name: "index_verifications_csv_email_to_organization" }
      t.string :email

      t.timestamps
    end
  end
end
