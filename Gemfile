# frozen_string_literal: true

source "https://rubygems.org"

DECIDIM_VERSION = { git: "https://github.com/decidim/decidim", branch: "release/0.22-stable" }

ruby RUBY_VERSION

gem "decidim", DECIDIM_VERSION
gem 'decidim-consultations', DECIDIM_VERSION
gem 'decidim-verifications', DECIDIM_VERSION

gem 'decidim-term_customizer', git: 'https://github.com/CodiTramuntana/decidim-module-term_customizer'
gem "decidim-action_delegator", git: "https://github.com/coopdevs/decidim-module-action_delegator"

gem 'virtus-multiparams'

gem "bootsnap", "~> 1.3"
gem 'deface'

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
