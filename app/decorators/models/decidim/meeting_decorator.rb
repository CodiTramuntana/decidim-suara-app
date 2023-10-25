# frozen_string_literal: true

Decidim::Meetings::Meeting.class_eval do
  scope :with_hour, lambda { |hour|
    case hour
    when "thirteen_am"
      where("start_time::time < ?", Time.zone.parse("13:00:00").strftime("%H:%M:%S"))
    else
      ""
    end
  }

  scope :with_day, lambda { |day|
    case day
    when "monday"
      where("extract(dow from start_time) = ?", 1)
    when "tuesday"
      where("extract(dow from start_time) = ?", 2)
    when "wednesday"
      where("extract(dow from start_time) = ?", 3)
    when "thursday"
      where("extract(dow from start_time) = ?", 4)
    when "friday"
      where("extract(dow from start_time) = ?", 5)
    when "saturday"
      where("extract(dow from start_time) = ?", 6)
    when "sunday"
      where("extract(dow from start_time) = ?", 7)
    else
      ""
    end
  }

  def self.ransackable_scopes(_auth_object = nil)
    [:with_any_type, :with_any_date, :with_any_space, :with_any_origin, :with_any_scope, :with_any_category, :with_any_global_category,
     :with_hour, :with_day]
  end
end
