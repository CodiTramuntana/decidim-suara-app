# frozen_string_literal: true

Decidim::FormBuilder.class_eval do
  # Public: Generates a select field for areas.
  #
  # name       - The name of the field (usually day)
  # collection - The values
  #
  # Returns a String.
  def days_select(name, collection, options = {}, html_options = {})
    selectables = @template.options_for_select(
      collection.map { |a| [a[:value], a[:key]] },
      selected: options[:selected]
    )

    select(name, selectables, options, html_options)
  end
end
