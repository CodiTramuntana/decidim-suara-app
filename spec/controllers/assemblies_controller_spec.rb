# frozen_string_literal: true

require "rails_helper"

module Decidim
  module Assemblies
    describe AssembliesController, type: :controller do
      routes { Decidim::Assemblies::Engine.routes }

      let(:organization) { create(:organization) }
      let(:current_user) { create(:user, :confirmed, organization:) }
      let(:metadata) { { ceco: "ceco", ceco_txt: "ceco_txt" } }
      let!(:authorization) { create(:authorization, user: current_user, name: "dummy_authorization_handler", metadata:) }

      let!(:published) do
        create(
          :assembly,
          :published,
          organization:,
          suara_permissions: { ceco: "a", ceco_txt: "b" }
        )
      end

      let!(:promoted) do
        create(
          :assembly,
          :published,
          :promoted,
          organization:,
          suara_permissions: { ceco: "ceco", ceco_txt: "b" }
        )
      end

      let!(:promoted_with_permissions) do
        create(
          :assembly,
          :published,
          :promoted,
          organization:,
          suara_permissions: { ceco: "ceco", ceco_txt: "ceco_txt" }
        )
      end

      let!(:promoted_without_permissions) do
        create(
          :assembly,
          :published,
          :promoted,
          organization:,
          suara_permissions: { ceco: "", ceco_txt: "", tipologia: "" }
        )
      end

      before do
        request.env["decidim.current_organization"] = organization
        sign_in current_user
      end

      describe "promoted_assemblies" do
        context "when user is admin" do
          let!(:current_user) { create(:user, :admin, :confirmed, organization:) }
          let!(:authorization) { create(:authorization, user: current_user, name: "dummy_authorization_handler", metadata:) }

          it "includes all promoted" do
            expect(controller.helpers.promoted_assemblies).to include(promoted)
            expect(controller.helpers.promoted_assemblies).to include(promoted_with_permissions)
            expect(controller.helpers.promoted_assemblies).to include(promoted_without_permissions)
          end
        end

        context "when user isn't admin and has permissions" do
          it "includes assemblies with permissions filters and without permissions" do
            expect(controller.helpers.promoted_assemblies).to include(promoted_with_permissions)
            expect(controller.helpers.promoted_assemblies).to include(promoted_without_permissions)
          end
        end

        context "when user isn't admin and has not permissions" do
          let!(:authorization) {}

          it "includes only assemblies without permissions filters" do
            expect(controller.helpers.promoted_assemblies).to contain_exactly(promoted_without_permissions)
          end
        end
      end

      describe "parent_assemblies" do
        let!(:child_assembly) { create(:assembly, parent: published, organization:) }

        context "when user is admin" do
          let!(:current_user) { create(:user, :admin, :confirmed, organization:) }
          let!(:authorization) { create(:authorization, user: current_user, name: "dummy_authorization_handler", metadata:) }

          it "includes all parent assemblies" do
            expect(controller.helpers.parent_assemblies).to include(promoted)
            expect(controller.helpers.parent_assemblies).to include(promoted_with_permissions)
            expect(controller.helpers.parent_assemblies).to include(promoted_without_permissions)
          end
        end

        context "when user isn't admin and has permissions" do
          it "includes only parent assemblies with permissions filters and without permissions" do
            expect(controller.helpers.parent_assemblies).to include(promoted_with_permissions)
            expect(controller.helpers.parent_assemblies).to include(promoted_without_permissions)
          end
        end

        context "when user isn't admin and has not permissions" do
          let!(:authorization) {}

          it "includes only parent assemblies without permissions filters" do
            expect(controller.helpers.parent_assemblies).to contain_exactly(promoted_without_permissions)
          end
        end

        describe "#show" do
          context "when user is admin" do
            let!(:current_user) { create(:user, :admin, :confirmed, organization:) }

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

            it "can not access processes with different permissions" do
              get :show, params: { slug: promoted.slug }
              expect(response).to have_http_status(:forbidden)
            end
          end

          context "when user is NOT admin and does NOT have permissions" do
            let!(:authorization) {}

            it "can access processes without permissions" do
              get :show, params: { slug: promoted_without_permissions.slug }
              expect(response).to have_http_status(:success)
            end

            it "can not access processes with some permissions" do
              get :show, params: { slug: promoted_with_permissions.slug }
              expect(response).to have_http_status(:forbidden)
            end

            it "can not access processes with different permissions" do
              get :show, params: { slug: promoted.slug }
              expect(response).to have_http_status(:forbidden)
            end
          end
        end
      end
    end
  end
end
