# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Consultations
    module Admin
      describe QuestionForm do
        subject do
          described_class
            .from_params(attributes)
            .with_context(
              current_organization: organization,
              current_consultation: consultation
            )
        end

        let(:organization) { create :organization }
        let(:consultation) { create :consultation, organization: organization }
        let(:scope) { create :scope, organization: organization }
        let(:slug) { "slug" }
        let(:title) do
          {
            en: "Title",
            es: "Título",
            ca: "Títol"
          }
        end
        let(:subtitle) do
          {
            en: "Subtitle",
            es: "Subtítulo",
            ca: "Subtítol"
          }
        end
        let(:promoter_group) do
          {
            en: "Promoter group",
            es: "Grupo promotor",
            ca: "Grup promotor"
          }
        end
        let(:participatory_scope) do
          {
            en: "Participatory scope",
            es: "Ámbito participativo",
            ca: "Àmbit participatiu"
          }
        end
        let(:what_is_decided) do
          {
            en: "What is decided",
            es: "Qué se decide",
            ca: "Què es decideix"
          }
        end
        let(:banner_image) { Decidim::Dev.test_file("city.jpeg", "image/jpeg") }
        let(:hero_image) { Decidim::Dev.test_file("city.jpeg", "image/jpeg") }
        let(:origin_scope) do
          {
            en: "",
            es: "",
            ca: ""
          }
        end
        let(:origin_title) do
          {
            en: "",
            es: "",
            ca: ""
          }
        end
        let(:origin_url) { nil }
        let(:external_voting) { false }
        let(:i_frame_url) { nil }
        let(:order) { 1 }
        let(:attributes) do
          {
            "question" => {
              "slug" => slug,
              "title_en" => title[:en],
              "title_es" => title[:es],
              "title_ca" => title[:ca],
              "subtitle_en" => subtitle[:en],
              "subtitle_es" => subtitle[:es],
              "subtitle_ca" => subtitle[:ca],
              "promoter_group_en" => promoter_group[:en],
              "promoter_group_es" => promoter_group[:es],
              "promoter_group_ca" => promoter_group[:ca],
              "participatory_scope_en" => participatory_scope[:en],
              "participatory_scope_es" => participatory_scope[:es],
              "participatory_scope_ca" => participatory_scope[:ca],
              "what_is_decided_en" => what_is_decided[:en],
              "what_is_decided_es" => what_is_decided[:es],
              "what_is_decided_ca" => what_is_decided[:ca],
              "decidim_scope_id" => scope&.id,
              "hero_image" => hero_image,
              "banner_image" => banner_image,
              "origin_scope_en" => origin_scope[:en],
              "origin_scope_es" => origin_scope[:es],
              "origin_scope_ca" => origin_scope[:ca],
              "origin_title_en" => origin_title[:en],
              "origin_title_es" => origin_title[:es],
              "origin_title_ca" => origin_title[:ca],
              "origin_url" => origin_url,
              "external_voting" => external_voting,
              "i_frame_url" => i_frame_url,
              "order": order
            }
          }
        end

        context "when everything is OK" do
          it { is_expected.to be_valid }
        end

        context "when subtitle is missing" do
          let(:subtitle) do
            {
              en: "",
              es: "",
              ca: ""
            }
          end

          it { is_expected.to be_valid }
        end

        context "when promoter_group is missing" do
          let(:promoter_group) do
            {
              en: "",
              es: "",
              ca: ""
            }
          end

          it { is_expected.to be_valid }
        end

        context "when participatory_scope is missing" do
          let(:participatory_scope) do
            {
              en: "",
              es: "",
              ca: ""
            }
          end

          it { is_expected.to be_valid }
        end

        context "when what_is_decided is missing" do
          let(:what_is_decided) do
            {
              en: "",
              es: "",
              ca: ""
            }
          end

          it { is_expected.to be_valid }
        end
      end
    end
  end
end
