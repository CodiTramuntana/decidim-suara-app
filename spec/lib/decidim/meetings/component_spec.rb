# frozen_string_literal: true

require "rails_helper"

describe "Meetings component" do # rubocop:disable RSpec/DescribeClass
  subject { component }

  let(:proposals_component) { create :component, manifest_name: "proposals" }
  let(:component) { create :component, manifest_name: "meetings", participatory_space: proposals_component.participatory_space }

  context "when card visualization are check in settings" do
    before do
      component.settings = { enable_cards_visualization: true }
    end

    it "save correctly component" do
      expect(component.save!).to be true
    end

    it "has correct settings" do
      expect(component.settings.enable_cards_visualization).to be true
    end
  end
end
