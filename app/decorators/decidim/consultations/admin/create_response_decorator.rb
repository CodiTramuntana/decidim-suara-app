# frozen_string_literal: true

Decidim::Consultations::Admin::CreateResponse.class_eval do
  def create_response
    Decidim::Consultations::Response.create(
      question: form.context.current_question,
      title: form.title,
      response_group: form.response_group,
      blank_vote: form.blank_vote
    )
  end
end
