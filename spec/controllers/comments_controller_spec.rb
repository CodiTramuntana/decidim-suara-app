# frozen_string_literal: true

require "rails_helper"

module Decidim
  module Comments
    describe CommentsController, type: :controller do
      routes { Decidim::Comments::Engine.routes }

      let(:organization) { create(:organization) }
      let(:metadata) { { ceco: "ceco", ceco_txt: "ceco_txt" } }
      let!(:authorization) { create(:authorization, user: current_user, name: "dummy_authorization_handler", metadata: metadata) }
      let!(:space_with_other_permissions) do
        create(
          :participatory_process,
          :published,
          organization: organization,
          suara_permissions: { ceco: "a", ceco_txt: "b" }
        )
      end

      let!(:space_with_permissions) do
        create(
          :participatory_process,
          :published,
          organization: organization,
          suara_permissions: { ceco: "ceco", ceco_txt: "ceco_txt" }
        )
      end

      let!(:space_without_permissions) do
        create(
          :participatory_process,
          :published,
          organization: organization,
          suara_permissions: { ceco: "", ceco_txt: "", tipologia: "" }
        )
      end

      let(:component) { create(:component, participatory_space: participatory_process) }
      let(:commentable) { create(:dummy_resource, component: component) }

      before do
        request.env["decidim.current_organization"] = organization
        sign_in current_user
      end

      describe "POST create" do
        context "even when user is admin" do
          let!(:current_user) { create(:user, :admin, :confirmed, organization: organization) }
          let(:comment_params) do
            {
              commentable_gid: commentable.to_signed_global_id.to_s,
              body: "This is a new comment",
              alignment: 0
            }
          end

          context "when space permissions are blank" do
            let(:participatory_process) { space_without_permissions }

            it "can only comment on places where she has permissions" do
              post :create, xhr: true, params: { comment: comment_params }
              expect(subject).to render_template(:create)
            end
          end

          context "when space permissions match user permissions" do
            let(:participatory_process) { space_with_permissions }

            it "can only comment on places where she has permissions" do
              post :create, xhr: true, params: { comment: comment_params }
              expect(response).to have_http_status(:success)
            end
          end

          context "when space permissions doesn't match user permissions" do
            let(:participatory_process) { space_with_other_permissions }

            it "can NOT comment on places where she doesn't has permissions" do
              post :create, xhr: true, params: { comment: comment_params }
              expect(response).to have_http_status(:forbidden)
            end
          end
        end
      end
    end
  end
end
