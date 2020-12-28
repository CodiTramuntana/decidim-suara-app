# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Consultations
    describe MultiVoteForm do
      subject { described_class.from_params(attributes).with_context(context) }

      let(:question) { create :question, :multiple }
      let(:response1) { create :response, question: question }
      let(:response2) { create :response, question: question }
      let(:response3) { create :response, question: question }
      let(:response4) { create :response, question: question }
      let(:response_blank_vote) { create :response, question: question, blank_vote: true }
      let(:responses) { [response1.id, response2.id] }
      let(:attributes) do
        {
          responses: responses
        }
      end
      let(:context) do
        {
          "current_question" => question
        }
      end

      it { is_expected.to be_valid }

      context 'when one reponse is a blank vote' do
        let(:responses) { [response_blank_vote.id] }

        it { is_expected.to be_valid }
      end
    end
  end
end
