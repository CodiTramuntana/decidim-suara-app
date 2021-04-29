# frozen_string_literal: true

Decidim::Meetings::ApplicationHelper.class_eval do
  def filter_hours_values
    Decidim::CheckBoxesTreeHelper::TreeNode.new(
      Decidim::CheckBoxesTreeHelper::TreePoint.new("thirteen_am", t("decidim.meetings.meetings.filters.hours_values.before_thirteen_am"))
    )
  end

  def filter_weekdays_values
    days = []
    days << { key: "monday", value: t("decidim.meetings.meetings.filters.weekdays_values.monday") }
    days << { key: "tuesday", value: t("decidim.meetings.meetings.filters.weekdays_values.tuesday") }
    days << { key: "wednesday", value: t("decidim.meetings.meetings.filters.weekdays_values.wednesday") }
    days << { key: "thursday", value: t("decidim.meetings.meetings.filters.weekdays_values.thursday") }
    days << { key: "friday", value: t("decidim.meetings.meetings.filters.weekdays_values.friday") }
    days << { key: "saturday", value: t("decidim.meetings.meetings.filters.weekdays_values.saturday") }
    days << { key: "sunday", value: t("decidim.meetings.meetings.filters.weekdays_values.sunday") }

    days
  end

  def month_meetings(meetings, month)
    meetings.where("extract(month from start_time) = ?", month)
  end
end
