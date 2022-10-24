# frozen_string_literal: true

require "rails_helper"

module Decidim::Consultations
  describe ConsultationParticipantsSerializer do
    let(:subject) { described_class.new(result) }
    let(:created_at) { Time.zone.now.rfc3339 }

    describe "#serialize" do
      context "with item 1" do
        let(:result) do
          [
            "Author_name 1",
            "author.email-1@example.net",
            true,
            false,
            created_at
          ]
        end

        it "returns serialized item 1" do
          expect(subject.serialize).to eq(
            author_name: "Author_name 1",
            author_email: "author.email-1@example.net",
            did_vote: true,
            delegated_vote: false,
            vote_created_at: created_at
          )
        end
      end

      context "with item 2" do
        let(:result) do
          [
            "Author_name 2",
            "author.email-2@example.net",
            false,
            true,
            Time.zone.now.rfc3339
          ]
        end

        it "returns serialized item 1" do
          expect(subject.serialize).to eq(
            author_name: "Author_name 2",
            author_email: "author.email-2@example.net",
            did_vote: false,
            delegated_vote: true,
            vote_created_at: created_at
          )
        end
      end
    end
  end
end
