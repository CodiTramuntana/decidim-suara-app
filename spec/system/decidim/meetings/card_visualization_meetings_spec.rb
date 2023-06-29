# frozen_string_literal: true

require "spec_helper"

describe "Card visualization meeting", :slow, type: :system do
  include_context "with a component"
  let(:manifest_name) { "meetings" }

  let!(:category) { create :category, participatory_space: participatory_process }
  let!(:scope) { create :scope, organization: organization }
  # using admin to avoid supervisor permissions checking
  let(:user) { create :user, :admin, :confirmed, organization: organization }
  let(:scoped_participatory_process) { create(:participatory_process, :with_steps, organization: organization, scope: scope) }
  let!(:first_meeting) { create(:meeting, :published, component: component, scope: scope, start_time: Time.zone.parse("2023-07-26 11:00:00")) }
  let!(:second_meeting) { create(:meeting, :published, component: component, scope: scope, start_time: Time.zone.parse("2023-07-28 11:00:00")) }

  describe "when cards visualization is uncheck" do
    let!(:scope2) { create :scope, organization: participatory_process.organization }

    before do
      allow(Time).to receive(:now).and_return(Time.zone.parse("2023-07-15 13:30"))

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
    let!(:scope2) { create :scope, organization: participatory_process.organization }

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
