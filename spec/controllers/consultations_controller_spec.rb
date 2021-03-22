# frozen_string_literal: true

require "rails_helper"

module Decidim
  module Consultations
    describe ConsultationsController, type: :controller do
      routes { Decidim::Consultations::Engine.routes }

      let(:organization) { create(:organization) }
      let(:current_user) { create(:user, :confirmed, organization: organization) }
      let(:metadata) { { ceco: "ceco", ceco_txt: "ceco_txt" } }
      let!(:authorization) { create(:authorization, user: current_user, name: "dummy_authorization_handler", metadata: metadata) }

      let!(:published_with_filter) do
        create(
          :consultation,
          :published,
          organization: organization,
          suara_permissions: { ceco: "ceco", ceco_txt: "ceco_txt" }
        )
      end

      let!(:published_without_filter) do
        create(
          :consultation,
          :published,
          organization: organization,
          suara_permissions: { ceco: "", ceco_txt: "" }
        )
      end

      let!(:published_with_other_filter) do
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
          let!(:authorization) { create(:authorization, user: current_user, name: "dummy_authorization_handler", metadata: metadata) }

          it "includes all consultations" do
            expect(controller.helpers.consultations).to include(published_with_filter)
            expect(controller.helpers.consultations).to include(published_without_filter)
            expect(controller.helpers.consultations).to include(published_with_other_filter)
          end
        end

        context "when user isn't admin and has permissions" do
          it "includes consultations with permissions filters and without permissions" do
            expect(controller.helpers.collection).to include(published_with_filter)
            expect(controller.helpers.collection).to include(published_without_filter)
          end
        end

        context "when user isn't admin and has not permissions" do
          let!(:authorization) {}

          it "includes consultations with permissions filters and without permissions" do
            expect(controller.helpers.collection).to include(published_with_filter)
            expect(controller.helpers.collection).to include(published_without_filter)
          end
        end
      end

      it "does not raise error to call current_participatory_space" do
        expect { controller.send(:current_participatory_space) }.not_to raise_error
      end
    end
  end
end
