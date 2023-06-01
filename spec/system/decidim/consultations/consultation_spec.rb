# frozen_string_literal: true

require "rails_helper"

describe "Consultation", type: :system do
  let!(:organization) { create(:organization) }
  let!(:consultation) { create(:consultation, :published, organization:, start_voting_date: Time.zone.now) }
  let!(:user) { create :user, :admin, :confirmed, organization: }
  let!(:question) { create :question, consultation:, scope: consultation.highlighted_scope }

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
      let(:consultation) { create(:consultation, :published, organization:, start_voting_date: Time.zone.local(2022, 9, 21, 9, 0, 0), end_voting_date: Time.zone.local(2022, 9, 21, 15, 0, 0)) }

      before do
        allow(Time.zone).to receive(:now).and_return(Time.zone.local(2022, 9, 21, 11, 0, 0))
        visit decidim_consultations.question_path(question, locale: I18n.locale)
      end

      it "user can vote a question in consultation" do
        expect(page).to have_content("Vote")
      end
    end

    context "when the end voting date is earlier than now" do
      let(:consultation) { create(:consultation, :published, organization:, start_voting_date: Time.zone.local(2022, 9, 21, 9, 0, 0), end_voting_date: Time.zone.local(2022, 9, 21, 15, 0, 0)) }

      before do
        allow(Time.zone).to receive(:now).and_return(Time.zone.local(2022, 9, 21, 15, 0o5, 0))
        visit decidim_consultations.question_path(question)
      end

      it "user can not vote a question in consultation" do
        expect(page).not_to have_content("Vote")
      end
    end

    context "and show questions left to response" do
      before do
        switch_to_host(organization.host)
        login_as user, scope: :user
      end

      it "show 1/1 left to response without votes" do
        expect(page).to have_content("Questions left to response: 1/1")
      end

      context "and question has one vote" do
        let!(:response) { create :response, question: }

        before do
          visit decidim_consultations.question_path(question)
          click_link(id: "vote_button")
          click_button translated(response.title)
          click_button "Confirm"
          visit decidim_consultations.consultation_path(consultation)
        end

        it "show 0/1 left to response with a response" do
          expect(page).to have_content("Questions left to response: 0/1")
        end
      end
    end
  end
end
