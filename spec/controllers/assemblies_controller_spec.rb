# frozen_string_literal: true

require "rails_helper"

module Decidim
  module Assemblies
    describe AssembliesController, type: :controller do
      routes { Decidim::Assemblies::Engine.routes }

      let(:organization) { create(:organization) }
      let(:current_user) { create(:user, :confirmed, organization: organization) }
      let(:metadata) { { ceco: "ceco", ceco_txt: "ceco_txt" } }
      let!(:authorization) { create(:authorization, user: current_user, name: "dummy_authorization_handler", metadata: metadata) }

      let!(:published) do
        create(
          :assembly,
          :published,
          organization: organization,
          suara_permissions: { ceco: "a", ceco_txt: "b" }
        )
      end

      let!(:promoted) do
        create(
          :assembly,
          :published,
          :promoted,
          organization: organization,
          suara_permissions: { ceco: "a", ceco_txt: "b" }
        )
      end

      let!(:promoted_with_filter) do
        create(
          :assembly,
          :published,
          :promoted,
          organization: organization,
          suara_permissions: { ceco: "ceco", ceco_txt: "ceco_txt" }
        )
      end

      let!(:promoted_without_filter) do
        create(
          :assembly,
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

      describe "promoted_assemblies" do
        context "when user is admin" do
          let!(:current_user) { create(:user, :admin, :confirmed, organization: organization) }
          let!(:authorization) { create(:authorization, user: current_user, name: "dummy_authorization_handler", metadata: metadata) }

          it "includes all promoted" do
            expect(controller.helpers.promoted_assemblies).to include(promoted)
            expect(controller.helpers.promoted_assemblies).to include(promoted_with_filter)
            expect(controller.helpers.promoted_assemblies).to include(promoted_without_filter)
          end
        end

        context "when user isn't admin and has permissions" do
          it "includes assemblies with permissions filters and without permissions" do
            expect(controller.helpers.promoted_assemblies).to include(promoted_with_filter)
            expect(controller.helpers.promoted_assemblies).to include(promoted_without_filter)
          end
        end

        context "when user isn't admin and has not permissions" do
          let!(:authorization) {}

          it "includes only assemblies without permissions filters" do
            expect(controller.helpers.promoted_assemblies).to contain_exactly(promoted_without_filter)
          end
        end
      end

      describe "parent_assemblies" do
        let!(:child_assembly) { create(:assembly, parent: published, organization: organization) }

        context "when user is admin" do
          let!(:current_user) { create(:user, :admin, :confirmed, organization: organization) }
          let!(:authorization) { create(:authorization, user: current_user, name: "dummy_authorization_handler", metadata: metadata) }

          it "includes all parent assemblies" do
            expect(controller.helpers.parent_assemblies).to include(promoted)
            expect(controller.helpers.parent_assemblies).to include(promoted_with_filter)
            expect(controller.helpers.parent_assemblies).to include(promoted_without_filter)
          end
        end

        context "when user isn't admin and has permissions" do
          it "includes only parent assemblies with permissions filters and without permissions" do
            expect(controller.helpers.parent_assemblies).to include(promoted_with_filter)
            expect(controller.helpers.parent_assemblies).to include(promoted_without_filter)
          end
        end

        context "when user isn't admin and has not permissions" do
          let!(:authorization) {}

          it "includes only parent assemblies without permissions filters" do
            expect(controller.helpers.parent_assemblies).to contain_exactly(promoted_without_filter)
          end
        end
      end
    end
  end
end
