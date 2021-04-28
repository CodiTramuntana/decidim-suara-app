# frozen_string_literal: true

Decidim::Meetings::ApplicationHelper.class_eval do
  def filter_hours_values
    Decidim::CheckBoxesTreeHelper::TreeNode.new(
      Decidim::CheckBoxesTreeHelper::TreePoint.new("thirteen_am", t("decidim.meetings.meetings.filters.hours_values.before_thirteen_am"))
    )
  end
end
