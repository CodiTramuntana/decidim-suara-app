# frozen_string_literal: true

Decidim::Consultations::MultiVoteForm.class_eval do
  def valid_num_of_votes
    blank_votes = Decidim::Consultations::Response
                  .find(responses)
                  .select { |response| response.blank_vote == true }

    return if responses.count.between?(context.current_question.min_votes, context.current_question.max_votes) || blank_votes.present?

    errors.add(
      :responses,
      I18n.t('activerecord.errors.models.decidim/consultations/vote.attributes.question.invalid_num_votes')
    )
  end
end
