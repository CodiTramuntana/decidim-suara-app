# frozen_string_literal: true

source "https://rubygems.org"

DECIDIM_VERSION = { git: "https://github.com/CodiTramuntana/decidim.git", branch: "release/0.26-stable" }.freeze

ruby RUBY_VERSION

gem "decidim", DECIDIM_VERSION
gem "decidim-consultations", DECIDIM_VERSION
gem "decidim-verifications", DECIDIM_VERSION

gem "decidim-action_delegator", git: "https://github.com/CodiTramuntana/decidim-module-action_delegator.git", branch: "first_ite/import_delegations_csv"
gem "decidim-cdtb", git: "https://github.com/CodiTramuntana/decidim-module-cdtb.git"
gem "decidim-term_customizer", git: "https://github.com/CodiTramuntana/decidim-module-term_customizer.git", branch: "fix/translation_set_query_consultations_question"
gem "decidim-verifications-csv_email", git: "https://github.com/CodiTramuntana/decidim-verifications-csv_emails.git", tag: "v0.1.1"
gem "decidim-verifications-members_picker", git: "https://github.com/gencat/decidim-verifications-members_picker.git", tag: "0.0.4"

gem "omniauth-rails_csrf_protection", "~> 1.0"
gem "virtus-multiparams"

gem "deface"
gem "savon", "~> 2.12.0"
gem "wicked_pdf"

gem "puma"
gem "uglifier", ">= 1.3.0"
gem "webpacker"

gem "figaro", ">= 1.1.1"
gem "openssl"

# if deploying to a dedicated server
gem "daemons"
gem "delayed_job_active_record"
gem "whenever"
# elsif deploying to Heroku
# gem "redis"
# gem "sidekiq"
# group :production do
#   gem "fog-aws"
#   gem "rack-ssl-enforcer"
#   gem "rails_12factor"
# end
# endif

group :development, :test do
  gem "better_errors"
  gem "binding_of_caller"
  gem "bootsnap"
  gem "byebug", platform: :mri
  gem "decidim-dev", DECIDIM_VERSION
  gem "faker"
end

group :development do
  gem "letter_opener_web"
  gem "listen"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console"
end

group :test do
  gem "rails-controller-testing"
end
