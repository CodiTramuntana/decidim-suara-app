# frozen_string_literal: true

require "spec_helper"

module Decidim
  describe DecidimDeviseMailer, type: :mailer do
    let(:organization) { create(:organization, name: "Test Organization") }
    let(:user) { create(:user, :admin, organization: organization) }
    let(:mail) { described_class.invitation_instructions(user, "foo", invitation_instructions: "invite_private_user") }

    describe "email subject" do
      it "includes the rigth subject" do
        expect(mail.subject).to match("You've been invited to a private participatory process on #{organization.name}")
      end
    end

    describe "email complete body" do
      describe "mail header" do
        let(:title) { "PLATAFORMA ENSUARA&#39;T" }
        let(:subtitle) { "Get informed, participate and decide" }

        it "includes the title" do
          expect(email_body(mail)).to match(title)
        end

        it "includes the subtitle" do
          expect(email_body(mail)).to match(subtitle)
        end

        it "includes the td with background image" do
          expect(email_body(mail)).to have_css("td.decidim-bar")
        end
      end

      describe "mail body" do
        let(:custom_organization_name) { "Ensuara&#39;t" }

        it "includes the user name" do
          expect(email_body(mail)).to match("Hello #{user.name}")
        end

        it "includes the invitation text with custom organization name" do
          expect(email_body(mail)).to match("A new virtual participation space is now available at #{custom_organization_name}")
        end

        it "includes the click link" do
          expect(email_body(mail)).to have_link("HERE")
        end
      end

      describe "mail footer" do
        let(:footer) { "Virtual Participation Plan 2021" }

        it "includes the title" do
          expect(email_body(mail)).to match(footer)
        end
      end
    end
  end
end
