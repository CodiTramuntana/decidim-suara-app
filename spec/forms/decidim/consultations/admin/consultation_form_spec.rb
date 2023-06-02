# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Consultations
    module Admin
      describe ConsultationForm do
        subject { described_class.from_params(attributes).with_context(current_organization: organization) }

        let(:organization) { create :organization }
        let(:scope) { create :scope, organization: organization }
        let(:title) do
          {
            en: "Title",
            es: "Título",
            ca: "Títol"
          }
        end
        let(:subtitle) do
          {
            en: "Subtitle",
            es: "Subtítulo",
            ca: "Subtítol"
          }
        end
        let(:description) do
          {
            en: "Description",
            es: "Descripción",
            ca: "Descripció"
          }
        end
        let(:slug) { "slug" }
        let(:start_voting_date) { Time.zone.now }
        let(:end_voting_date) { 1.month.from_now }

        let(:attributes) do
          {
            "consultation" => {
              "title_en" => title[:en],
              "title_es" => title[:es],
              "title_ca" => title[:ca],
              "subtitle_en" => subtitle[:en],
              "subtitle_es" => subtitle[:es],
              "subtitle_ca" => subtitle[:ca],
              "description_en" => description[:en],
              "description_es" => description[:es],
              "description_ca" => description[:ca],
              "slug" => slug,
              "decidim_highlighted_scope_id" => scope&.id,
              "start_voting_date" => start_voting_date,
              "end_voting_date" => end_voting_date
            }
          }
        end

        context "when everything is OK" do
          it { is_expected.to be_valid }
        end
      end
    end
  end
end
