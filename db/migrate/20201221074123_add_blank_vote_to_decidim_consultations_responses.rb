class AddBlankVoteToDecidimConsultationsResponses < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_consultations_responses, :blank_vote, :boolean
  end
end
