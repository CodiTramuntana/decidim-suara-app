# frozen_string_literal: true

Decidim::Meetings::MeetingsController.class_eval do
  private

  def meetings
    @meetings ||= paginate(search.result.not_hidden.order(start_time: :asc))
  end

  def default_filter_params
    {
      search_text: "",
      date: %w(upcoming),
      activity: "all",
      scope_id: default_filter_scope_params,
      category_id: default_filter_category_params,
      state: nil,
      origin: default_filter_origin_params,
      type: default_filter_type_params,
      hour: "",
      day: ""
    }
  end
end
