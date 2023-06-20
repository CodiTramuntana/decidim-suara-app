# frozen_string_literal: true

require "spec_helper"

module Decidim
  module ParticipatoryProcesses
    module Admin
      describe ParticipatoryProcessForm do
        subject { described_class.from_params(attributes).with_context(current_organization: organization) }

        let(:organization) { create :organization }
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
        let(:weight) { 1 }
        let(:description) do
          {
            en: "Description",
            es: "Descripción",
            ca: "Descripció"
          }
        end
        let(:short_description) do
          {
            en: "Short description",
            es: "Descripción corta",
            ca: "Descripció curta"
          }
        end
        let(:slug) { "slug" }
        let(:attachment) { Decidim::Dev.test_file("city.jpeg", "image/jpeg") }
        let(:show_metrics) { true }
        let(:show_statistics) { true }
        let(:suara_permissions) do
          {
            ceco: "ceco",
            ceco_txt: "ceco_txt",
            tipologia: "tipologia",
            grup_empleados: "grup_empleados",
            estat_soci: "estat_soci",
            derechovoto: "derechovoto",
            estat_ocup: "estat_ocup"
          }
        end
        let(:attributes) do
          {
            "participatory_process" => {
              "title_en" => title[:en],
              "title_es" => title[:es],
              "title_ca" => title[:ca],
              "subtitle_en" => subtitle[:en],
              "subtitle_es" => subtitle[:es],
              "subtitle_ca" => subtitle[:ca],
              "weight" => weight,
              "description_en" => description[:en],
              "description_es" => description[:es],
              "description_ca" => description[:ca],
              "short_description_en" => short_description[:en],
              "short_description_es" => short_description[:es],
              "short_description_ca" => short_description[:ca],
              "hero_image" => attachment,
              "banner_image" => attachment,
              "slug" => slug,
              "show_metrics" => show_metrics,
              "show_statistics" => show_statistics,
              "suara_permissions" => suara_permissions
            }
          }
        end

        context "when everything is OK" do
          it { is_expected.to be_valid }
        end

        context "when suara permissions is empty" do
          let(:suara_permissions) do
            {
              ceco: "",
              ceco_txt: "",
              tipologia: "",
              grup_empleados: "",
              estat_soci: "",
              derechovoto: "",
              estat_ocup: ""
            }
          end

          it { is_expected.to be_valid }
        end
      end
    end
  end
end
