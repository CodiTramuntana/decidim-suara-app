# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "decidim@suara.coop"
  layout "mailer"
end
