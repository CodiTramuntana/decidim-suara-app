# frozen_string_literal: true

# ---------------------------------------------------------
# Extend Decidim::Meetings component
# ---------------------------------------------------------
def add_attribute_to_global_settings(component, attr_name, type, default: false)
  component.settings(:global).attribute(attr_name.to_sym, type: type, default: default)
end

component = Decidim.find_component_manifest :meetings
add_attribute_to_global_settings(component, :enable_cards_visualization, :boolean)

# ---------------------------------------------------------
# override decidim-meetings/app/controllers/decidim/meetings/meetings_controller.rb#default_filter_params
# ---------------------------------------------------------

# This override must be done after Decidim's component_filterable is included because it is where the method is defined

# require the controller so that Decidim's ComponentFilterable is already included
require "decidim/meetings/component_filterable"
require "decidim/meetings/meetings_controller"
# now we can override the #default_filter method in the controller
require "decidim/meetings/component_filterable_override"
Decidim::Meetings::MeetingsController
  .include(Decidim::Meetings::ComponentFilterableOverride)
