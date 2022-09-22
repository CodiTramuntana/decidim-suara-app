# frozen_string_literal: true

require "rails_helper"

module Decidim::Meetings
  describe MeetingSearch do
    subject { described_class.new(params).results }

    let(:component) { create :component, manifest_name: "meetings" }
    let(:default_params) { { component: component, organization: component.organization } }
    let(:params) { default_params }
    let!(:meeting1) do
      create(
        :meeting,
        component: component,
        start_time: Time.zone.parse("2021-04-28T11:00:00"),
        published_at: Time.zone.now
      )
    end
    let!(:meeting2) do
      create(
        :meeting,
        component: component,
        start_time: Time.zone.parse("2021-04-28T14:00:00"),
        published_at: Time.zone.now
      )
    end

    let!(:meeting3) do
      create(
        :meeting,
        component: component,
        start_time: Time.zone.parse("2021-04-26T14:00:00"),
        published_at: Time.zone.now
      )
    end

    describe "filters" do
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
            expect(subject).to match_array [meeting1, meeting2, meeting3]
          end
        end
      end

      context "with day" do
        let(:params) { default_params.merge(day: day) }

        context "when is monday" do
          let(:day) { ["monday"] }

          it "only returns that are in monday" do
            expect(subject).to match_array [meeting3]
          end
        end

        context "when no day is set" do
          let(:day) { [""] }

          it "returns all meetings" do
            expect(subject).to match_array [meeting1, meeting2, meeting3]
          end
        end
      end
    end
  end
end
