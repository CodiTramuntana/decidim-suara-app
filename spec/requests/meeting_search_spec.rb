# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Meeting search", type: :request do
  include Decidim::ComponentPathHelper

  subject { response.body }

  let(:component) { create :meeting_component }
  let(:user) { create :user, organization: component.organization }
  let(:participatory_space) { component.participatory_space }
  let(:organization) { participatory_space.organization }
  let(:filter_params) { {} }

  let!(:meeting1) do
    create(
      :meeting,
      :published,
      author: user,
      component: component,
      start_time: Time.zone.parse("2024-06-28 11:00:00"),
      description: Decidim::Faker::Localized.literal("Curabitur arcu erat, accumsan id imperdiet et.")
    )
  end
  let!(:meeting2) do
    create(
      :meeting,
      :published,
      author: user,
      component: component,
      start_time: Time.zone.parse("2023-06-28 14:00:00"),
      description: Decidim::Faker::Localized.literal("Nulla TestCheck accumsan tincidunt.")
    )
  end

  let!(:meeting3) do
    create(
      :meeting,
      :published,
      author: user,
      component: component,
      start_time: Time.zone.parse("2023-06-26 14:00:00"),
      description: Decidim::Faker::Localized.literal("Nulla TestCheck accumsan tincidunt.")
    )
  end

  let(:request_path) { Decidim::EngineRouter.main_proxy(component).meetings_path }

  before do
    allow(Time).to receive(:now).and_return(Time.zone.parse("2023-06-15 13:30"))

    get(
      request_path,
      params: { filter: filter_params },
      headers: { "HOST" => component.organization.host }
    )
  end

  it "displays all meetings without any filters" do
    expect(subject).to include(translated(meeting1.title))
    expect(subject).to include(translated(meeting2.title))
    expect(subject).to include(translated(meeting3.title))
  end

  describe "filters" do
    context "with hour" do
      let(:filter_params) { { hour: hour } }

      context "when thirteen_am" do
        let(:hour) { ["thirteen_am"] }

        it "only returns that are before thirteen am" do
          expect(subject).to include(translated(meeting1.title))
        end
      end

      context "when all hours" do
        let(:hour) { [""] }

        it "returns all meetings" do
          expect(subject).to include(translated(meeting1.title))
          expect(subject).to include(translated(meeting2.title))
          expect(subject).to include(translated(meeting3.title))
        end
      end
    end

    context "with day" do
      let(:filter_params) { { day: day } }

      context "when is monday" do
        let(:day) { ["monday"] }

        it "only returns that are in monday" do
          expect(subject).to include(translated(meeting3.title))
        end
      end

      context "when no day is set" do
        let(:day) { [""] }

        it "returns all meetings" do
          expect(subject).to include(translated(meeting1.title))
          expect(subject).to include(translated(meeting2.title))
          expect(subject).to include(translated(meeting3.title))
        end
      end
    end
  end
end
