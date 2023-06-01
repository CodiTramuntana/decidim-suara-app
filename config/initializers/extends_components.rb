# frozen_string_literal: true

# Extends the Decidim::Meetings component.

def add_attribute_to_global_settings(component, attr_name, type, default: false)
  component.settings(:global).attribute(attr_name.to_sym, type:, default:)
end

component = Decidim.find_component_manifest :meetings
add_attribute_to_global_settings(component, :enable_cards_visualization, :boolean)
