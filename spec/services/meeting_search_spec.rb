# frozen_string_literal: true

require "rails_helper"

module Decidim::Meetings
  describe MeetingSearch do
    subject { described_class.new(params).results }

    let(:component) { create :component, manifest_name: "meetings" }
    let(:default_params) { { component: component, organization: component.organization } }
    let(:params) { default_params }

    describe "filters" do
      let!(:meeting1) do
        create(
          :meeting,
          component: component,
          start_time: Time.zone.parse("2021-04-28T11:00:00")
        )
      end
      let!(:meeting2) do
        create(
          :meeting,
          component: component,
          start_time: Time.zone.parse("2021-04-28T14:00:00")
        )
      end

      context "with hour" do
        let(:params) { default_params.merge(hour: hour) }

        context "when thirteen_am" do
          let(:hour) { ["thirteen_am"] }

          it "only returns that are before thriteen am" do
            expect(subject).to match_array [meeting1]
          end
        end

        context "when all hours" do
          let(:hour) { [""] }

          it "returns all meetings" do
            expect(subject).to match_array [meeting1, meeting2]
          end
        end
      end
    end
  end
end
