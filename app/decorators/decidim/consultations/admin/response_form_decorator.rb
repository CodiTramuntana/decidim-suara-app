# frozen_string_literal: true

Decidim::Consultations::Admin::ResponseForm.class_eval do
  attribute :question_slug, String
  attribute :blank_vote

  validates :question_slug, presence: true
  validate :question_exist?
  validate :only_one_blank_vote_response

  def only_one_blank_vote_response
    question = Decidim::Consultations::Question.find_by(slug: question_slug) if question_slug
    blank_vote_ = blank_vote == '1'
  
    if question&.responses&.where(blank_vote: true).count == 1 && blank_vote_ && id != question&.responses&.find_by(blank_vote: true)&.id
      errors.add(:blank_vote, :invalid)
    end
  end

  def question_exist?
    if Decidim::Consultations::Question.find_by(slug: question_slug).blank?
      errors.add(:base, :invalid)
    end
  end
end