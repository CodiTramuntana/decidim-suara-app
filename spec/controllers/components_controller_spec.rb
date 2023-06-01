# frozen_string_literal: true

require "rails_helper"

module Decidim
  module Meetings
    describe MeetingsController, type: :controller do
      routes { Decidim::Meetings::Engine.routes }

      let(:organization) { create(:organization) }
      let(:metadata) { { ceco: "ceco", ceco_txt: "ceco_txt" } }
      let!(:authorization) { create(:authorization, user: current_user, name: "dummy_authorization_handler", metadata:) }

      let!(:space_with_permissions) do
        create(
          :consultation,
          :published,
          organization:,
          suara_permissions: { ceco: "ceco", ceco_txt: "ceco_txt" }
        )
      end

      let!(:space_without_permissions) do
        create(
          :consultation,
          :published,
          organization:,
          suara_permissions: { ceco: "", ceco_txt: "" }
        )
      end

      let!(:space_with_other_permissions) do
        create(
          :consultation,
          :published,
          organization:,
          suara_permissions: { ceco: "ceco", ceco_txt: "b" }
        )
      end

      let(:meeting_component) { create(:meeting_component, :with_creation_enabled, participatory_space:) }
      let(:component) { create :meeting, :published, component: meeting_component }

      before do
        request.env["decidim.current_organization"] = organization
        request.env["decidim.current_participatory_space"] = participatory_space
        request.env["decidim.current_component"] = meeting_component
        sign_in current_user
      end

      describe "#show" do
        context "when user is admin" do
          let!(:current_user) { create(:user, :admin, :confirmed, organization:) }

          context "when space permissions are blank" do
            let(:participatory_space) { space_without_permissions }

            it "can access the component" do
              get :show, params: { id: component.id }
              expect(response).to have_http_status(:success)
            end
          end

          context "when space permissions match user permissions" do
            let(:participatory_space) { space_with_permissions }

            it "can access the component" do
              get :show, params: { id: component.id }
              expect(response).to have_http_status(:success)
            end
          end

          context "when space permissions doesn't match user permissions" do
            let(:participatory_space) { space_with_other_permissions }

            it "can access the component" do
              get :show, params: { id: component.id }
              expect(response).to have_http_status(:success)
            end
          end
        end

        context "when user is NOT admin" do
          let!(:current_user) { create(:user, :confirmed, organization:) }

          context "when space permissions are blank" do
            let(:participatory_space) { space_without_permissions }

            it "can access the component" do
              get :show, params: { id: component.id }
              expect(response).to have_http_status(:success)
            end
          end

          context "when space permissions match user permissions" do
            let(:participatory_space) { space_with_permissions }

            it "can access the component" do
              get :show, params: { id: component.id }
              expect(response).to have_http_status(:success)
            end
          end

          context "when space permissions doesn't match user permissions" do
            let(:participatory_space) { space_with_other_permissions }

            it "can NOT access the component" do
              get :show, params: { id: component.id }
              expect(response).to have_http_status(:forbidden)
            end
          end
        end
      end
    end
  end
end
