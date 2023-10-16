# frozen_string_literal: true

require "spec_helper"
require "decidim/dev/test/promoted_participatory_processes_shared_examples"

module Decidim
  module ParticipatoryProcesses
    describe ParticipatoryProcessesController, type: :controller do
      routes { Decidim::ParticipatoryProcesses::Engine.routes }

      let(:organization) { create(:organization) }
      let(:current_user) { create(:user, :confirmed, organization: organization) }
      let(:metadata) { { ceco: "ceco", ceco_txt: "ceco_txt" } }
      let!(:authorization) { create(:authorization, user: current_user, name: "sap_authorization_handler", metadata: metadata) }
      let!(:promoted) do
        create(
          :participatory_process,
          :published,
          :promoted,
          organization: organization,
          suara_permissions: { ceco: "a", ceco_txt: "b" }
        )
      end

      let!(:promoted_with_permissions) do
        create(
          :participatory_process,
          :published,
          :promoted,
          organization: organization,
          suara_permissions: { ceco: "ceco", ceco_txt: "ceco_txt" }
        )
      end

      let!(:promoted_without_permissions) do
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
          let!(:authorization) { create(:authorization, user: current_user, name: "sap_authorization_handler", metadata: metadata) }

          it "includes all promoted" do
            expect(controller.helpers.collection).to include(promoted)
            expect(controller.helpers.collection).to include(promoted_with_permissions)
            expect(controller.helpers.collection).to include(promoted_without_permissions)
          end
        end

        context "when user isn't admin and has permissions" do
          it "includes only processes with permissions filters and without permissions" do
            expect(controller.helpers.collection).to include(promoted_with_permissions)
            expect(controller.helpers.collection).to include(promoted_without_permissions)
          end
        end

        context "when user isn't admin and has not permissions" do
          let!(:authorization) { nil }

          it "includes only processes without permissions filters" do
            expect(controller.helpers.collection).to contain_exactly(promoted_without_permissions)
          end
        end
      end

      describe "#show" do
        context "when user is admin" do
          let!(:current_user) { create(:user, :admin, :confirmed, organization: organization) }

          it "can access processes with all kind of permissions" do
            get :show, params: { slug: promoted.slug }
            expect(response).to have_http_status(:success)
            get :show, params: { slug: promoted_with_permissions.slug }
            expect(response).to have_http_status(:success)
            get :show, params: { slug: promoted_without_permissions.slug }
            expect(response).to have_http_status(:success)
          end
        end

        context "when user is NOT admin but HAS permissions" do
          it "can access processes with same permissions" do
            get :show, params: { slug: promoted_with_permissions.slug }
            expect(response).to have_http_status(:success)
          end

          it "can access processes without permissions" do
            get :show, params: { slug: promoted_without_permissions.slug }
            expect(response).to have_http_status(:success)
          end

          it "can not access processes with different" do
            get :show, params: { slug: promoted.slug }
            expect(response).to have_http_status(:forbidden)
          end
        end

        context "when user is NOT admin and does NOT have permissions" do
          let!(:authorization) { nil }

          it "can access processes without permissions" do
            get :show, params: { slug: promoted_without_permissions.slug }
            expect(response).to have_http_status(:success)
          end

          it "can not access processes with some permissions" do
            get :show, params: { slug: promoted_with_permissions.slug }
            expect(response).to have_http_status(:forbidden)
          end

          it "can not access processes with different" do
            get :show, params: { slug: promoted.slug }
            expect(response).to have_http_status(:forbidden)
          end
        end
      end
    end
  end
end
