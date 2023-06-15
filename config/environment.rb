# frozen_string_literal: true

# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

require "decidim/meetings/extensions/component_filterable"
Decidim::Meetings::MeetingsController.prepend(Decidim::Meetings::Extensions::ComponentFilterable)
