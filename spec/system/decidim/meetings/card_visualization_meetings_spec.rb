# frozen_string_literal: true

require "rails_helper"

describe "Card visualization meeting", :slow, type: :system do
  include_context "with a component"
  let(:manifest_name) { "meetings" }

  let!(:category) { create :category, participatory_space: participatory_process }
  let!(:scope) { create :scope, organization: organization }
  let!(:user) { create :user, :confirmed, organization: organization }
  let(:scoped_participatory_process) { create(:participatory_process, :with_steps, organization: organization, scope: scope) }

  describe "when cards visualization is uncheck" do
    let!(:scope_2) { create :scope, organization: participatory_process.organization }

    before do
      component.settings = { enable_cards_visualization: false }
      component.save!
      create_list(:meeting, 2, component: component, scope: scope)
      create(:meeting, component: component, scope: scope_2)
      create(:meeting, component: component, scope: nil)
      visit_component
    end

    it "show meetings in a list" do
      expect(page).to have_css(".meeting-list")
    end
  end
end
