# frozen_string_literal: true

source "https://rubygems.org"

DECIDIM_VERSION = { git: "https://github.com/decidim/decidim", branch: "release/0.21-stable" }

ruby RUBY_VERSION

gem "decidim", DECIDIM_VERSION
gem 'decidim-initiatives', DECIDIM_VERSION
gem 'decidim-consultations'
gem 'decidim-verifications'

gem 'virtus-multiparams'

gem "bootsnap", "~> 1.3"

gem "puma", "~> 4.0"
gem "uglifier", "~> 4.1"
gem 'figaro'
gem 'whenever'
gem 'delayed_job_active_record'
gem 'daemons'
gem 'decidim-verifications-members_picker', git: 'https://github.com/gencat/decidim-verifications-members_picker.git', tag: '0.0.2'

gem "wicked_pdf"
gem "faker", "~> 1.9"

gem 'savon', '~> 2.12.0'

gem "rails", "< 6"

group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri

  gem "decidim-dev", DECIDIM_VERSION
end

group :development do
  gem "letter_opener_web", "~> 1.3.0"
  gem "listen", "~> 3.1"
  gem "spring", "~> 2.0"
  gem "spring-watcher-listen", "~> 2.0"
  gem "web-console", "~> 3.5"
end
