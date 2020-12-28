# frozen_string_literal: true

Decidim::Consultations::Admin::UpdateQuestionConfiguration.class_eval do
  def attributes
    {
      max_votes: form.max_votes,
      min_votes: form.min_votes,
      instructions: form.instructions,
      blank_vote: form.blank_vote
    }
  end
end
