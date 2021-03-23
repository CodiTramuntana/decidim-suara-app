# frozen_string_literal: true

require "rails_helper"

module Decidim
  module ParticipatoryProcesses
    module ContentBlocks
      describe HighlightedProcessesCell, type: :cell do
        subject { cell(content_block.cell, content_block).call }

        let(:organization) { create(:organization) }
        let(:content_block) { create :content_block, organization: organization, manifest_name: :highlighted_processes, scope_name: :homepage, settings: settings }
        let(:current_user) { create(:user, :confirmed, organization: organization) }
        let(:metadata) { { ceco: "ceco", ceco_txt: "ceco_txt" } }
        let!(:authorization) { create(:authorization, user: current_user, name: "dummy_authorization_handler", metadata: metadata) }

        let!(:participatory_process_with_filter) { create(:participatory_process, :published, :promoted, organization: organization, suara_permissions: { ceco: "ceco", ceco_txt: "ceco_txt" }) }
        let!(:participatory_process_with_other_filter) { create(:participatory_process, :published, :promoted, organization: organization, suara_permissions: { ceco: "a", ceco_txt: "b" }) }
        let!(:participatory_process_without_filter) { create(:participatory_process, :published, :promoted, organization: organization, suara_permissions: { ceco: "", ceco_txt: "" }) }

        controller Decidim::PagesController

        before do
          allow(controller).to receive(:current_organization).and_return(organization)
        end

        context "when user is an admin" do
          let!(:current_user) { create(:user, :admin, :confirmed, organization: organization) }
          let!(:authorization) { create(:authorization, user: current_user, name: "dummy_authorization_handler", metadata: metadata) }

          it "includes all participatory processes" do
            within "#highlighted-processes" do
              expect(subject).to have_selector(".card--process", count: 3)
            end
          end
        end

        context "when user is not an admin and has permissions" do
          it "includes only participatory processes with permissions and without permissions" do
            within "#highlighted-processes" do
              expect(subject).to have_selector(".card--process", count: 2)
            end
          end
        end

        context "when user is not an admin and not has permissions" do
          let!(:authorization) {}

          it "includes only participatory processes without permissions" do
            within "#highlighted-processes" do
              expect(subject).to have_selector(".card--process", count: 1)
            end
          end
        end
      end
    end
  end
end
