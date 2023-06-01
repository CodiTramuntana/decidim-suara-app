# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Consultations
    module Admin
      describe ResponseForm do
        subject do
          described_class
            .from_params(attributes)
            .with_context(
              current_organization: question.organization,
              current_question: question
            )
        end

        let(:organization) { create :organization }
        let(:consultation) { create :consultation, organization: }
        let(:question) { create :question }
        let(:response_group) { create :response_group }
        let(:title) do
          {
            en: "Title",
            es: "Título",
            ca: "Títol"
          }
        end
        let(:blank_vote) { true }
        let(:attributes) do
          {
            "response" => {
              "title_en" => title[:en],
              "title_es" => title[:es],
              "title_ca" => title[:ca],
              "decidim_consultations_response_group_id" => response_group,
              "blank_vote" => blank_vote,
              "question_slug" => question.slug
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
