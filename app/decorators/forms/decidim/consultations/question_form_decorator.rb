# frozen_string_literal: true

# This decorator remove the fields validations in QuestionForm
Decidim::Consultations::Admin::QuestionForm.class_eval do
  attributes = [:subtitle, :promoter_group, :participatory_scope, :what_is_decided]

  attributes.each do |attribute|
    _validators.delete(attribute)
  end

  _validate_callbacks.each do |callback|
    next unless callback.raw_filter.respond_to? :attributes

    attributes.each do |attribute|
      callback.raw_filter.attributes.delete attribute
    end
  end
end
