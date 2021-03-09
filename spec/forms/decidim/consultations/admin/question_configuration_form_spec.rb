# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Consultations
    module Admin
      describe QuestionConfigurationForm do
        subject do
          described_class
            .from_params(attributes)
            .with_context(
              current_organization: question.organization,
              current_question: question
            )
        end

        let(:organization) { create :organization }
        let(:question) { create :question }
        let(:info) do
          {
            en: "Information",
            es: "Información",
            ca: "Informaci"
          }
        end
        let(:blank_vote) { true }
        let(:attributes) do
          {
            "question" => {
              "title_en" => info[:en],
              "title_es" => info[:es],
              "title_ca" => info[:ca],
              "blank_vote" => blank_vote
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
