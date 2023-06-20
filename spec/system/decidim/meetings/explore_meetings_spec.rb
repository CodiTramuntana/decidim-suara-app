# frozen_string_literal: true

require "spec_helper"

describe "Explore meetings", :slow, type: :system do
  include_context "with a component"
  let(:manifest_name) { "meetings" }
  # using admin to avoid supervisor permissions checking
  let(:user) { create :user, :admin, :confirmed, organization: organization }

  before do
    # Required for the link to be pointing to the correct URL with the server
    # port since the server port is not defined for the test environment.
    allow(ActionMailer::Base).to receive(:default_url_options).and_return(port: Capybara.server_port)
    allow(Time).to receive(:now).and_return(Time.zone.parse("2023-06-15 13:30"))

    component_scope = create :scope, parent: participatory_process.scope
    component_settings = component["settings"]["global"].merge!(scopes_enabled: true, scope_id: component_scope.id)
    component.update!(settings: component_settings)
  end

  describe "index" do
    context "when filtering with card visualization" do
      it "allows filtering by hour" do
        component_settings = component["settings"]["global"].merge!(enable_cards_visualization: true)
        component.update!(settings: component_settings)

        in_hour_meeting = create(:meeting, :published, component: component, start_time: Time.zone.parse("2023-06-28 11:00:00"))
        out_hour_meeting = create(:meeting, :published, component: component, start_time: Time.zone.parse("2023-06-28 16:00:00"))
        sign_in user
        visit_component

        within ".hour_check_boxes_tree_filter" do
          check "Before 13am"
        end

        expect(page).to have_css(".card--meeting", count: 1)
        expect(page).to have_content(translated(in_hour_meeting.title))

        within ".hour_check_boxes_tree_filter" do
          uncheck "Before 13am"
        end

        expect(page).to have_css(".card--meeting", count: 2)
        expect(page).to have_content(translated(out_hour_meeting.title))
      end

      it "allows filtering by day" do
        component_settings = component["settings"]["global"].merge!(enable_cards_visualization: true)
        component.update!(settings: component_settings)
        monday_meeting = create(:meeting, :published, component: component, start_time: Time.zone.parse("2023-06-26 11:00:00"))
        sign_in user
        visit_component

        within ".day_days_select_filter" do
          find("option[value='monday']").click
        end

        expect(page).to have_css(".card--meeting", count: 1)
        expect(page).to have_content(translated(monday_meeting.title))
      end
    end

    context "when filtering without card visualization" do
      it "allows filtering by hour" do
        component_settings = component["settings"]["global"].merge!(enable_cards_visualization: false)
        component.update!(settings: component_settings)
        in_hour_meeting = create(:meeting, :published, component: component, start_time: Time.zone.parse("2023-06-28 11:00:00"))
        out_hour_meeting = create(:meeting, :published, component: component, start_time: Time.zone.parse("2023-06-28 16:00:00"))
        sign_in user
        visit_component

        within ".hour_check_boxes_tree_filter" do
          check("Before 13am", allow_label_click: true)
        end

        expect(page).to have_css(".meeting-list li", count: 1)
        expect(page).to have_content(translated(in_hour_meeting.title))

        within ".hour_check_boxes_tree_filter" do
          uncheck("Before 13am", allow_label_click: true)
        end

        expect(page).to have_css(".meeting-list li", count: 2)
        expect(page).to have_content(translated(out_hour_meeting.title))
      end

      it "allows filtering by day" do
        component_settings = component["settings"]["global"].merge!(enable_cards_visualization: false)
        component.update!(settings: component_settings)
        monday_meeting = create(:meeting, :published, component: component, start_time: Time.zone.parse("2023-06-26 11:00:00"))
        sign_in user
        visit_component

        within ".day_days_select_filter" do
          find("option[value='monday']").click
        end

        expect(page).to have_css(".meeting-list li", count: 1)
        expect(page).to have_content(translated(monday_meeting.title))
      end
    end
  end
end
