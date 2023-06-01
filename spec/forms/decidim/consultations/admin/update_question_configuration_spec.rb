# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Consultations
    module Admin
      describe UpdateQuestionConfiguration do
        let(:question) { create :question }
        let(:min_votes) { "3" }
        let(:max_votes) { "5" }
        let(:blank_vote) { true }
        let(:params) do
          {
            question: {
              id: question.id,
              min_votes:,
              max_votes:,
              instructions_en: "Foo instructions",
              instructions_ca: "Foo instructions",
              instructions_es: "Foo instructions",
              blank_vote:
            }
          }
        end
        let(:form) { QuestionConfigurationForm.from_params(params) }
        let(:command) { described_class.new(question, form) }

        describe "when the form is not valid" do
          before do
            allow(form).to receive(:invalid?).and_return(true)
          end

          it "broadcasts invalid" do
            expect { command.call }.to broadcast(:invalid)
          end

          it "doesn't update the consultation" do
            command.call
            question.reload

            expect(question.blank_vote).not_to be(true)
          end
        end

        describe "when question is not valid" do
          before do
            allow(question).to receive(:valid?).and_return(false)
          end

          it "broadcasts invalid" do
            expect { command.call }.to broadcast(:invalid)
          end

          it "doesn't update the consultation" do
            command.call
            question.reload

            expect(question.blank_vote).not_to be(true)
          end
        end

        describe "when the form is valid" do
          it "broadcasts ok" do
            expect { command.call }.to broadcast(:ok)
          end

          it "updates the question" do
            expect { command.call }.to broadcast(:ok)
            question.reload

            expect(question.min_votes).to eq(3)
            expect(question.max_votes).to eq(5)
            expect(question.instructions["en"]).to eq("Foo instructions")
            expect(question.blank_vote).to be(true)
          end
        end
      end
    end
  end
end
