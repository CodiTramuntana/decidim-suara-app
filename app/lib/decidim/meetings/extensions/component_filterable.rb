# frozen_string_literal: true

module Decidim
  module Meetings
    module Extensions
      module ComponentFilterable
        def default_filter_params
          {
            search_text_cont: "",
            with_any_date: "upcoming",
            activity: "all",
            with_availability: "",
            with_any_scope: default_filter_scope_params,
            with_any_category: default_filter_category_params,
            with_any_state: nil,
            with_any_origin: default_filter_origin_params,
            with_any_type: default_filter_type_params,
            # Suara customization
            hour: "",
            day: ""
            # Suara customization
          }
        end
      end
    end
  end
end
