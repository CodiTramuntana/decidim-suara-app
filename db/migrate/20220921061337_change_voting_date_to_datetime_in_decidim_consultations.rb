# frozen_string_literal: true

class ChangeVotingDateToDatetimeInDecidimConsultations < ActiveRecord::Migration[6.0]
  def change
    change_column :decidim_consultations, :start_voting_date, :datetime
    change_column :decidim_consultations, :end_voting_date, :datetime
  end
end
