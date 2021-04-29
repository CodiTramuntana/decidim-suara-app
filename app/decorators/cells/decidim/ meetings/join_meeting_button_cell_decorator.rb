# frozen_string_literal: true

Decidim::Meetings::JoinMeetingButtonCell.class_eval do
  alias_method :button_classes_original, :button_classes

  def button_classes
    if current_component.settings.enable_cards_visualization
      button_classes_original
    else
      "link small"
    end
  end
end
