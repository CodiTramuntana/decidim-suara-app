# frozen_string_literal: true

source "https://rubygems.org"

DECIDIM_VERSION = { git: "https://github.com/CodiTramuntana/decidim.git", branch: "release/0.24-stable" }.freeze

ruby RUBY_VERSION

gem "decidim", DECIDIM_VERSION
gem "decidim-consultations", DECIDIM_VERSION
gem "decidim-verifications", DECIDIM_VERSION

gem "decidim-action_delegator", git: "https://github.com/coopdevs/decidim-module-action_delegator.git"
gem "decidim-term_customizer", git: "https://github.com/CodiTramuntana/decidim-module-term_customizer"

gem "virtus-multiparams"

gem "bootsnap", "~> 1.3"
gem "deface"

gem "daemons"
gem "decidim-verifications-members_picker", git: "https://github.com/gencat/decidim-verifications-members_picker.git", tag: "0.0.2"
gem "delayed_job_active_record"
gem "figaro"
gem "puma"
gem "uglifier", "~> 4.1"
gem "whenever"

gem "faker", "~> 2.14.0"
gem "wicked_pdf"

gem "savon", "~> 2.12.0"

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

group :test do
  gem "rails-controller-testing"
end