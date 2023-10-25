# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Consultations
    describe ConsultationsController, type: :controller do
      routes { Decidim::Consultations::Engine.routes }

      let(:organization) { create(:organization) }
      let(:current_user) { create(:user, :confirmed, organization: organization) }
      let(:metadata) { { ceco: "ceco", ceco_txt: "ceco_txt" } }
      let!(:authorization) { create(:authorization, user: current_user, name: "sap_authorization_handler", metadata: metadata) }

      let!(:published_with_permissions) do
        create(
          :consultation,
          :published,
          organization: organization,
          suara_permissions: { ceco: "ceco", ceco_txt: "ceco_txt" }
        )
      end

      let!(:published_without_permissions) do
        create(
          :consultation,
          :published,
          organization: organization,
          suara_permissions: { ceco: "", ceco_txt: "" }
        )
      end

      let!(:published_with_other_permissions) do
        create(
          :consultation,
          :published,
          organization: organization,
          suara_permissions: { ceco: "a", ceco_txt: "b" }
        )
      end

      before do
        request.env["decidim.current_organization"] = organization
        sign_in current_user
      end

      describe "published_consultations" do
        context "when user is admin" do
          let!(:current_user) { create(:user, :admin, :confirmed, organization: organization) }
          let!(:authorization) { create(:authorization, user: current_user, name: "sap_authorization_handler", metadata: metadata) }

          it "includes all consultations" do
            expect(controller.helpers.consultations).to include(published_with_permissions)
            expect(controller.helpers.consultations).to include(published_without_permissions)
            expect(controller.helpers.consultations).to include(published_with_other_permissions)
          end
        end

        context "when user isn't admin and has permissions" do
          it "includes consultations with permissions filters and without permissions" do
            expect(controller.helpers.collection).to include(published_with_permissions)
            expect(controller.helpers.collection).to include(published_without_permissions)
          end
        end

        context "when user isn't admin and has not permissions" do
          let!(:authorization) { nil }

          it "includes consultations with permissions filters and without permissions" do
            expect(controller.helpers.collection).to include(published_with_permissions)
            expect(controller.helpers.collection).to include(published_without_permissions)
          end
        end
      end

      describe "#show" do
        context "when user is admin" do
          let!(:current_user) { create(:user, :admin, :confirmed, organization: organization) }

          it "can access processes with all kind of permissions" do
            get :show, params: { slug: published_with_permissions.slug }
            expect(response).to have_http_status(:success)
            get :show, params: { slug: published_with_other_permissions.slug }
            expect(response).to have_http_status(:success)
            get :show, params: { slug: published_without_permissions.slug }
            expect(response).to have_http_status(:success)
          end
        end

        context "when user is NOT admin but HAS permissions" do
          it "can access processes with same permissions" do
            get :show, params: { slug: published_with_permissions.slug }
            expect(response).to have_http_status(:success)
          end

          it "can access processes without permissions" do
            get :show, params: { slug: published_without_permissions.slug }
            expect(response).to have_http_status(:success)
          end

          it "can not access processes with different" do
            get :show, params: { slug: published_with_other_permissions.slug }
            expect(response).to have_http_status(:forbidden)
          end
        end

        context "when user is NOT admin and does NOT have permissions" do
          let!(:authorization) { nil }

          it "can access processes without permissions" do
            get :show, params: { slug: published_without_permissions.slug }
            expect(response).to have_http_status(:success)
          end

          it "can not access processes with some permissions" do
            get :show, params: { slug: published_with_other_permissions.slug }
            expect(response).to have_http_status(:forbidden)
          end

          it "can not access processes with different" do
            get :show, params: { slug: published_with_permissions.slug }
            expect(response).to have_http_status(:forbidden)
          end
        end
      end
    end
  end
end
