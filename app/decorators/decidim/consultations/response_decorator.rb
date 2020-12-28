# frozen_string_literal: true

Decidim::Consultations::Response.class_eval do
  validate :only_one_blank_vote_response

  def only_one_blank_vote_response
    if question.responses.where(blank_vote: true).count.positive? && blank_vote
      errors.add(:blank_vote, :invalid)
    end
  end
end
