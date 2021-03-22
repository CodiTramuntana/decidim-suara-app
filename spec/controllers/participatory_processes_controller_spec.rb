# frozen_string_literal: true

require "rails_helper"
require "decidim/dev/test/promoted_participatory_processes_shared_examples"

module Decidim
  module ParticipatoryProcesses
    describe ParticipatoryProcessesController, type: :controller do
      routes { Decidim::ParticipatoryProcesses::Engine.routes }

      let(:organization) { create(:organization) }
      let(:current_user) { create(:user, :confirmed, organization: organization) }
      let(:metadata) { { ceco: "ceco", ceco_txt: "ceco_txt" } }
      let!(:authorization) { create(:authorization, user: current_user, name: "dummy_authorization_handler", metadata: metadata) }
      let!(:promoted) do
        create(
          :participatory_process,
          :published,
          :promoted,
          organization: organization,
          suara_permissions: { ceco: "a", ceco_txt: "b" }
        )
      end

      let!(:promoted_with_filter) do
        create(
          :participatory_process,
          :published,
          :promoted,
          organization: organization,
          suara_permissions: { ceco: "ceco", ceco_txt: "ceco_txt" }
        )
      end

      let!(:promoted_without_filter) do
        create(
          :participatory_process,
          :published,
          :promoted,
          organization: organization,
          suara_permissions: { ceco: "", ceco_txt: "", tipologia: "" }
        )
      end

      before do
        request.env["decidim.current_organization"] = organization
        sign_in current_user
      end

      describe "promoted_participatory_processes" do
        context "when user is admin" do
          let!(:current_user) { create(:user, :admin, :confirmed, organization: organization) }
          let!(:authorization) { create(:authorization, user: current_user, name: "dummy_authorization_handler", metadata: metadata) }

          it "includes only promoted" do
            expect(controller.helpers.promoted_participatory_processes).to include(promoted)
            expect(controller.helpers.promoted_participatory_processes).to include(promoted_with_filter)
            expect(controller.helpers.promoted_participatory_processes).to include(promoted_without_filter)
          end
        end

        context "when user isn't admin and has permissions" do
          it "includes only processes with permissions filters" do
            expect(controller.helpers.promoted_participatory_processes).to include(promoted_with_filter)
            expect(controller.helpers.promoted_participatory_processes).to include(promoted_without_filter)
          end
        end

        context "when user isn't admin and has not permissions" do
          let!(:authorization) {}

          it "includes only processes with permissions filters" do
            expect(controller.helpers.promoted_participatory_processes).to contain_exactly(promoted_without_filter)
          end
        end
      end
    end
  end
end
