# frozen_string_literal: true

require "rails_helper"

module Decidim::Consultations
  describe Participation do
    subject { described_class.new(consultation).results }

    let!(:consultation) { create :consultation }
    let(:organization) { consultation.organization }
    let!(:questions) { create_list(:question, 3, consultation: consultation) }
    let!(:responses) do
      questions.collect { |question| create(:response, question: question) }
    end

    describe "open consultation participation" do
      it "#results raises exception" do
        expect { subject }.to raise_exception("Can not compute results on a Consultation that is not closed.")
      end
    end

    describe "closed consultation participation" do
      before do
        consultation.update(end_voting_date: Time.zone.now - 1.minute)
      end

      context "without participation" do
        it "returns an empty list" do
          expect(subject).to eq([])
        end
      end

      context "with one user that did not participate" do
        let!(:non_participating_user) { create(:user, organization: organization) }

        it "returns an empty list" do
          expect(subject).to eq([])
        end
      end

      context "with one user that voted" do
        let!(:vote) do
          response= responses.first
          create(:vote, question: response.question, response: response)
        end

        it "returns results with one voted" do
          author= vote.author
          expected_result = [
            [
              author.name,
              author.email,
              true,
              false,
              vote.created_at.rfc3339
            ]
          ]
          expect(subject).to eq(expected_result)
        end
      end

      context "with delegated votes" do
        let!(:action_delegator_setting) { create(:setting, consultation: consultation) }
        let(:granter) { create(:user, organization: organization) }
        let(:grantee) { create(:user, organization: organization) }
        let!(:delegation) { create(:delegation, setting: action_delegator_setting, granter: granter, grantee: grantee) }

        let(:question) { create(:question, consultation: consultation) }
        let(:granter_vote) { create(:vote, author: delegation.granter, question: question) }
        let!(:version) { ::PaperTrail::Version.create(item: granter_vote, event: :create, whodunnit: grantee.id, decidim_action_delegator_delegation_id: delegation.id) }
        let(:grantee_vote) { create(:vote, author: grantee, question: question) }

        it "returns two voters one for its vote and one for the delegated" do
          expected_result = [granter_vote, grantee_vote].collect.with_index do |vote, idx|
            author= vote.author

            [
              author.name,
              author.email,
              true,
              idx.even?,
              vote.created_at.rfc3339
            ]
          end
          expect(subject).to eq(expected_result.sort { |a, b| a.first <=> b.first })
        end
      end
    end
  end
end
