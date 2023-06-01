# frozen_string_literal: true

require "rails_helper"

module Decidim::Consultations
  describe ExportConsultationParticipantsJob do
    subject { described_class }

    let(:organization) { create(:organization) }
    let(:user) { create(:user, :admin, :confirmed, organization:) }

    let!(:consultation) { create(:consultation, :finished, :published_results, organization:) }
    let!(:question) { create(:question, consultation:, title: { "ca" => "question_title" }) }
    let!(:response) { create(:response, question:, title: { "ca" => "A" }) }
    let!(:other_response) { create(:response, question:, title: { "ca" => "B" }) }

    let!(:other_user) { create(:user, :admin, :confirmed, organization:) }
    let!(:another_user) { create(:user, :admin, :confirmed, organization:) }
    let!(:yet_another_user) { create(:user, :admin, :confirmed, organization:) }

    let(:votes) { consultation.questions.first.total_votes }
    let!(:vote_1) { question.votes.create(author: user, response:) }
    let!(:vote_2) { question.votes.create(author: other_user, response:) }
    let!(:vote_3) { question.votes.create(author: another_user, response:) }
    let!(:vote_4) { question.votes.create(author: yet_another_user, response: other_response) }

    let(:expected_csv) do
      votes= [vote_1, vote_2, vote_3, vote_4].sort { |v1, v2| v1.author.name <=> v2.author.name }
      csv_contents = votes.map do |vote|
        user= vote.author
        "#{user.name};#{user.email};true;false;#{vote.created_at.rfc3339}"
      end.join("\n")
      csv = "author_name;author_email;did_vote;delegated_vote;vote_created_at\n#{csv_contents}"
      csv.strip
    end

    before do
      create(:authorization, :direct_verification, user:, metadata: { membership_type: "producer", membership_weight: 2 })
      create(:authorization, :direct_verification, user: other_user, metadata: { membership_type: "consumer", membership_weight: 3 })
      create(:authorization, :direct_verification, user: another_user, metadata: { membership_type: "consumer", membership_weight: 1 })

      create(:authorization, :direct_verification, user: yet_another_user, metadata: { membership_type: "consumer", membership_weight: 1 })
    end

    describe "queue" do
      it "is queued to default" do
        expect(subject.queue_name).to eq "default"
      end
    end

    describe "#perform" do
      let(:mailer) { double(:mailer, deliver_now: true) }
      let(:exporter_class) { class_double(Decidim::Exporters::CSV) }
      let(:exporter) { instance_double(Decidim::Exporters::CSV, export: export_data) }

      let(:export_data) do
        double(
          :export_data,
          read: expected_csv
        )
      end

      it "fetches data calling participation" do
        participation = instance_double(Participation)
        expect(Participation)
          .to receive(:new).with(consultation).and_return(participation)
        expect(participation).to receive(:results).and_return([])

        subject.perform_now(user, consultation)
      end

      it "sends an export mail from the collection data" do
        allow(exporter_class).to receive(:new)
          .with(kind_of(Array), ConsultationParticipantsSerializer)
          .and_return(exporter)
        allow(Decidim::Exporters).to receive(:find_exporter)
          .with("CSV").and_return(exporter_class)

        expect(Decidim::ExportMailer)
          .to receive(:export)
          .with(
            user,
            I18n.t("decidim.admin.consultations.participants.export_filename"),
            export_data
          )
          .and_return(mailer)

        subject.perform_now(user, consultation)
      end

      context "when the consultation is active" do
        let!(:consultation) { create(:consultation, :active, organization:) }
        let(:export_data) { double(:export_data, read: "\n") }

        it "does not export anything" do
          expect(Decidim::ExportMailer).to receive(:export) do |_user, _name, export_data|
            expect(export_data.read).to eq("\n")
          end.and_return(mailer)

          subject.perform_now(user, consultation)
        end
      end

      context "when the consultation is finished" do
        context "and the results are published" do
          let!(:consultation) do
            create(:consultation, :finished, :published_results, organization:)
          end

          it "exports consultation's participation" do
            expect(Decidim::ExportMailer).to receive(:export) do |_user, _name, export_data|
              expect(export_data.read.strip).to eq(expected_csv)
            end.and_return(mailer)

            subject.perform_now(user, consultation)
          end
        end
      end
    end
  end
end
