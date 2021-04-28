# frozen_string_literal: true

Decidim::Meetings::Meeting.class_eval do
  scope :thirteen_am, -> { where("start_time::time < ?", "13:00:00") }
end
