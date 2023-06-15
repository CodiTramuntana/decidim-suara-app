# frozen_string_literal: true

Decidim::Meetings::MeetingsController.class_eval do
  private

  def meetings
    @meetings ||= paginate(search.result.not_hidden.order(start_time: :asc))
  end
end
