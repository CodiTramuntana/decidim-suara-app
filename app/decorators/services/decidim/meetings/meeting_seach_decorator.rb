# frozen_string_literal: true

Decidim::Meetings::MeetingSearch.class_eval do
  def search_hour
    apply_scopes(%w(thirteen_am), hour)
  end

  def search_day
    apply_scopes(%w(monday tuesday wednesday thursday friday saturday sunday), day)
  end
end