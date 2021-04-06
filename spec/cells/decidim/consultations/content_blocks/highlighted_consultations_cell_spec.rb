# frozen_string_literal: true

require "rails_helper"

module Decidim
  module Consultations
    module ContentBlocks
      describe HighlightedConsultationsCell, type: :cell do
        subject { cell(content_block.cell, content_block).call }

        let(:organization) { create(:organization) }
        let(:content_block) { create :content_block, organization: organization, manifest_name: :highlighted_consultations, scope_name: :homepage, settings: settings }
        let(:current_user) { create(:user, :confirmed, organization: organization) }
        let(:metadata) { { ceco: "ceco", ceco_txt: "ceco_txt" } }
        let!(:authorization) { create(:authorization, user: current_user, name: "dummy_authorization_handler", metadata: metadata) }

        let!(:consultation_with_filter) { create(:consultation, :active, organization: organization, suara_permissions: { ceco: "ceco", ceco_txt: "ceco_txt" }) }
        let!(:consultation_with_other_filter) { create(:consultation, :active, organization: organization, suara_permissions: { ceco: "a", ceco_txt: "b" }) }
        let!(:consultation_without_filter) { create(:consultation, :active, organization: organization, suara_permissions: { ceco: "", ceco_txt: "" }) }

        controller Decidim::HomepageController

        before do
          allow(controller).to receive(:current_organization).and_return(organization)
        end

        context "when user is an admin" do
          let!(:current_user) { create(:user, :admin, :confirmed, organization: organization) }
          let!(:authorization) { create(:authorization, user: current_user, name: "dummy_authorization_handler", metadata: metadata) }

          it "includes all assemblies" do
            within "#highlighted-consultation" do
              expect(subject).to have_selector(".card--process", count: 3)
            end
          end
        end

        context "when user is not an admin and has permissions" do
          it "includes only assemblies with permissions and without permissions" do
            within "#highlighted-consultation" do
              expect(subject).to have_selector(".card--process", count: 2)
            end
          end
        end

        context "when user is not an admin and not has permissions" do
          let!(:authorization) {}

          it "includes only assemblies without permissions" do
            within "#highlighted-consultation" do
              expect(subject).to have_selector(".card--process", count: 1)
            end
          end
        end
      end
    end
  end
end
