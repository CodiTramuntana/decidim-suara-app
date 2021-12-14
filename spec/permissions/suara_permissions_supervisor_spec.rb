# frozen_string_literal: true

require "rails_helper"

describe SuaraPermissionsSupervisor do
  let(:organization) { create(:organization) }
  let(:current_user) { create(:user, :confirmed, organization: organization) }
  let(:metadata) { { ceco: "ceco", ceco_txt: "ceco_txt" } }
  let!(:authorization) { create(:authorization, user: current_user, name: "dummy_authorization_handler", metadata: metadata) }
  let(:participatory_spaces) do
    [
      create(:assembly, :published, :promoted, organization: organization, suara_permissions: { ceco: "ceco", ceco_txt: "ceco_txt" }),
      create(:assembly, :published, :promoted, organization: organization, suara_permissions: { ceco: "ceco", ceco_txt: "ceco_txt", tipologia: "tipo", grup_empleados: "grup", estat_soci: "soci", derechovoto: "derecho", estat_ocup: "ocup" }),
      create(:assembly, :published, :promoted, organization: organization, suara_permissions: { ceco: "aa", ceco_txt: "bb", tipologia: "cc" }),
      create(:assembly, :published, :promoted, organization: organization, suara_permissions: { ceco: "a", ceco_txt: "b", tipologia: "c", grup_empleados: "d", estat_soci: "e", derechovoto: "f", estat_ocup: "g" }),
      create(:assembly, :published, :promoted, organization: organization, suara_permissions: { ceco: "", ceco_txt: "" }),
      create(:assembly, :published, :promoted, organization: organization, suara_permissions: {}),
      create(:assembly, :published, :promoted, organization: organization),
      create(:assembly, :published, :promoted, organization: organization, suara_permissions: { ceco: nil, ceco_txt: nil })
    ]
  end

  describe "without_permissions" do
    it "get assembly without any permissions" do
      expect(supervisor.without_permissions(participatory_spaces)).to contain_exactly(participatory_spaces[4], participatory_spaces[5], participatory_spaces[6], participatory_spaces[7])
    end
  end

  describe "filter_by_permissions" do
    context "when the user doesn't have permissions" do
      let(:metadata) { {} }

      it "doesn't have any assembly" do
        expect(supervisor.filter_by_permissions(participatory_spaces, authorization.metadata)).to be_empty
      end
    end

    context "when user has all permissions" do
      let(:metadata) { { ceco: "ceco", ceco_txt: "ceco_txt", tipologia: "tipo", grup_empleados: "grup", estat_soci: "soci", derechovoto: "derecho", estat_ocup: "ocup" } }

      it "get assemblies with the same permissions as user" do
        expect(supervisor.filter_by_permissions(participatory_spaces, authorization.metadata)).to contain_exactly(participatory_spaces[0], participatory_spaces[1])
      end
    end

    context "when user only has two permissions" do
      it "get assemblies with the same permissions as user" do
        expect(supervisor.filter_by_permissions(participatory_spaces, authorization.metadata)).to contain_exactly(participatory_spaces[0])
      end
    end

    context "when user has all permissions but differents to space permissions" do
      let(:metadata) { { ceco: "e", ceco_txt: "e", tipologia: "e", grup_empleados: "e", estat_soci: "e", derechovoto: "e", estat_ocup: "e" } }

      it "doesn't have any assembly" do
        expect(supervisor.filter_by_permissions(participatory_spaces, authorization.metadata)).to be_empty
      end
    end

    context "when user has some permissions but differents to space permissions" do
      let(:metadata) { { ceco: "e", ceco_txt: "e" } }

      it "doesn't have any assembly" do
        expect(supervisor.filter_by_permissions(participatory_spaces, authorization.metadata)).to be_empty
      end
    end
  end
end
