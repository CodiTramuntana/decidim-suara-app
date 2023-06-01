# frozen_string_literal: true

require "rails_helper"

describe "Card visualization meeting", :slow, type: :system do
  include_context "with a component"
  let(:manifest_name) { "meetings" }

  let!(:category) { create :category, participatory_space: participatory_process }
  let!(:scope) { create :scope, organization: }
  # using admin to avoid supervisor permissions checking
  let(:user) { create :user, :admin, :confirmed, organization: }
  let(:scoped_participatory_process) { create(:participatory_process, :with_steps, organization:, scope:) }
  let!(:first_meeting) { create(:meeting, component:, scope:, start_time: Time.zone.parse("2021-04-26T11:00:00")) }
  let!(:second_meeting) { create(:meeting, component:, scope: scope_2, start_time: Time.zone.parse("2021-04-28T11:00:00")) }

  describe "when cards visualization is uncheck" do
    let!(:scope_2) { create :scope, organization: participatory_process.organization }

    before do
      component.settings = { enable_cards_visualization: false }
      component.save!
      sign_in user
      visit_component
    end

    it "show meetings in a list in order by start time" do
      expect(page).to have_selector(".meeting-list li:first-child", text: first_meeting.title[:en])
      expect(page).to have_selector(".meeting-list li:last-child", text: second_meeting.title[:en])
    end
  end

  describe "when cards visualization is check" do
    let!(:scope_2) { create :scope, organization: participatory_process.organization }

    before do
      component.settings = { enable_cards_visualization: true }
      component.save!
      visit_component
    end

    it "show meetings in a cards in order by start time" do
      expect(page).to have_selector("#meetings div.column:first-child", text: first_meeting.title[:en])
      expect(page).to have_selector("#meetings div.column:last-child", text: second_meeting.title[:en])
    end
  end
end
