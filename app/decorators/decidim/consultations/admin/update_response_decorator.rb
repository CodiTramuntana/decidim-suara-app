# frozen_string_literal: true

Decidim::Consultations::Admin::UpdateResponse.class_eval do
  def attributes
    {
      title: form.title,
      blank_vote: form.blank_vote,
      response_group: form.response_group
    }
  end
end
