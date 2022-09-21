# frozen_string_literal: true

require "rails_helper"

describe "Consultation", type: :system do
  let!(:organization) { create(:organization) }
  let!(:consultation) { create(:consultation, :published, organization: organization, start_voting_date: Time.zone.now) }
  let!(:user) { create :user, :confirmed, organization: organization }

  before do
    switch_to_host(organization.host)
  end

  context "when requesting the consultation path" do
    before do
      visit decidim_consultations.consultation_path(consultation)
    end

    it "shows start voting date with correct format" do
      expect(page).to have_content(consultation.start_voting_date.strftime("%d/%m/%Y - %H:%M"))
    end

    context "when the end voting date is later than now" do
      let(:consultation) { create(:consultation, :published, organization: organization, start_voting_date: Time.zone.local(2022, 9, 21, 9, 0, 0), end_voting_date: Time.zone.local(2022, 9, 21, 15, 0, 0)) }
      let(:question) { create :question, consultation: consultation }

      before do
        allow(Time.zone).to receive(:now).and_return(Time.zone.local(2022, 9, 21, 11, 0, 0))
        visit decidim_consultations.question_path(question)
      end

      it "user can vote a question in consultation" do
        expect(page).to have_content("Vote")
      end
    end

    context "when the end voting date is earlier than now" do
      let(:consultation) { create(:consultation, :published, organization: organization, start_voting_date: Time.zone.local(2022, 9, 21, 9, 0, 0), end_voting_date: Time.zone.local(2022, 9, 21, 15, 0, 0)) }
      let(:question) { create :question, consultation: consultation }

      before do
        allow(Time.zone).to receive(:now).and_return(Time.zone.local(2022, 9, 21, 15, 0o5, 0))
        visit decidim_consultations.question_path(question)
      end

      it "user can not vote a question in consultation" do
        expect(page).not_to have_content("Vote")
      end
    end
  end
end
