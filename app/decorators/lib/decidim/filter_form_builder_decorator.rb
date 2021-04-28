# frozen_string_literal: true

Decidim::FilterFormBuilder.class_eval do
  # Wrap the days select in a custom fieldset.
  def days_select(method, collection, options = {})
    fieldset_wrapper(options[:legend_title], "#{method}_days_select_filter") do
      super(method, collection, options)
    end
  end
end
