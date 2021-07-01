# frozen_string_literal: true

require_relative "boot"

require "rails/all"

require "net/http"
require "openssl"
require "resolv-replace"
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DecidimCleanApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
  end
end
