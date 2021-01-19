class AddBlankVoteToDecidimConsultationsQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_consultations_questions, :blank_vote, :boolean
  end
end
