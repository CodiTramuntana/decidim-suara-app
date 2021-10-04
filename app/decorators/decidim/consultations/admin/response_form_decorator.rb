# frozen_string_literal: true

Decidim::Consultations::Admin::ResponseForm.class_eval do
  attribute :question_slug, String
  attribute :blank_vote

  validates :question_slug, presence: true
  validate :question_exist?
  validate :only_one_blank_vote_response

  # rubocop:disable Metrics/CyclomaticComplexity
  def only_one_blank_vote_response
    question = Decidim::Consultations::Question.find_by(slug: question_slug) if question_slug
    blank_vote_ = blank_vote == "1"

    errors.add(:blank_vote, :invalid) if question&.responses&.where(blank_vote: true)&.count == 1 && blank_vote_ && id != question&.responses&.find_by(blank_vote: true)&.id
  end
  # rubocop:enable Metrics/CyclomaticComplexity

  def question_exist?
    errors.add(:base, :invalid) if Decidim::Consultations::Question.find_by(slug: question_slug).blank?
  end
end
