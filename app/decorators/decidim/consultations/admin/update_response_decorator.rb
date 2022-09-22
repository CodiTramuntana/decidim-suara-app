# frozen_string_literal: true

Decidim::Consultations::Admin::UpdateResponse.class_eval do
  alias_method :original_attributes, :attributes

  def attributes
    blank_vote_attribute = {
      blank_vote: form.blank_vote
    }

    original_attributes.merge(blank_vote_attribute)
  end
end
