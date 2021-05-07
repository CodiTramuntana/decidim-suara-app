# frozen_string_literal: true

Decidim::Meetings::Meeting.class_eval do
  scope :thirteen_am, -> { where("start_time::time < ?", Time.zone.parse("13:00:00").strftime("%H:%M:%S")) }

  scope :monday, -> { where("extract(dow from start_time) = ?", 1) }
  scope :tuesday, -> { where("extract(dow from start_time) = ?", 2) }
  scope :wednesday, -> { where("extract(dow from start_time) = ?", 3) }
  scope :thursday, -> { where("extract(dow from start_time) = ?", 4) }
  scope :friday, -> { where("extract(dow from start_time) = ?", 5) }
  scope :saturday, -> { where("extract(dow from start_time) = ?", 6) }
  scope :sunday, -> { where("extract(dow from start_time) = ?", 7) }
end
