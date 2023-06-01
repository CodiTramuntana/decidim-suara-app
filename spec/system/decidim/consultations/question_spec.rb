# frozen_string_literal: true

require "rails_helper"

describe "Question", type: :system do
  let(:organization) { create(:organization) }
  let(:consultation) { create(:consultation, :published, organization:) }
  let(:question) { create :question, consultation: }

  context "when shows question information" do
    before do
      switch_to_host(organization.host)
      visit decidim_consultations.question_path(question, locale: I18n.locale)
    end

    it "shows the back to list button" do
      expect(page).to have_content("BACK TO QUESTIONS LIST")
    end

    it "not shows the hidden fields in basic question data" do
      expect(page).not_to have_i18n_content(question.promoter_group)
      expect(page).not_to have_i18n_content(question.scope.name)
      expect(page).not_to have_i18n_content(question.participatory_scope)
      expect(page).to have_i18n_content(question.question_context)

      expect(page).not_to have_i18n_content(question.what_is_decided)
    end

    context "when field question_context is blank" do
      let(:question) { create :question, consultation:, question_context: { ca: "", es: "", en: "" } }

      it "not shows question_context section" do
        click_button("Read more")

        expect(page).not_to have_content("CONTEXT")
      end
    end

    context "when field what_is_decided is blank" do
      let(:question) { create :question, consultation:, what_is_decided: { ca: "", es: "", en: "" } }

      it "not shows what_is_decided section" do
        click_button("Read more")

        expect(page).not_to have_content("WHAT IS DECIDED")
      end
    end
  end
end
