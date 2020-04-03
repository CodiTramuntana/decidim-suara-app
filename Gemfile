# frozen_string_literal: true

source "https://rubygems.org"

DECIDIM_VERSION = { git: "https://github.com/decidim/decidim", branch: "0.20-stable" }

ruby RUBY_VERSION

gem "decidim", DECIDIM_VERSION
gem 'decidim-initiatives'
gem 'decidim-consultations'

gem "bootsnap", "~> 1.3"

gem "puma", "~> 3.12.2"
gem "uglifier", "~> 4.1"
gem 'figaro'
gem 'whenever'
gem 'delayed_job_active_record'
gem 'daemons'

gem "wicked_pdf"
gem "faker", "~> 1.9"

group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri

  gem "decidim-dev", "0.20.0"
end

group :development do
  gem "letter_opener_web", "~> 1.3"
  gem "listen", "~> 3.1"
  gem "spring", "~> 2.0"
  gem "spring-watcher-listen", "~> 2.0"
  gem "web-console", "~> 3.5"
end
