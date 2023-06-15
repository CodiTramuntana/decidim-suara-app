# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Assemblies
    module Admin
      describe AssemblyForm do
        subject { described_class.from_params(attributes).with_context(current_organization: organization) }

        let(:organization) { create :organization }
        let(:assembly_type) { create :assemblies_type, organization: organization }
        let(:assembly_type_id) { assembly_type.id }
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
        let(:attachment) { upload_test_file(Decidim::Dev.test_file("city.jpeg", "image/jpeg")) }
        let(:show_statistics) { true }
        let(:private_space) { true }
        let(:purpose_of_action) do
          {
            en: "Purpose of action",
            es: "propósito de la acción",
            ca: "propòsit d'acció"
          }
        end
        let(:composition) do
          {
            en: "Composition of internal working groups",
            es: "Composición de los grupos internos",
            ca: "Composició dels grups interns"
          }
        end
        let(:creation_date) { 2.days.from_now }
        let(:created_by) { "others" }
        let(:created_by_other) do
          {
            en: "Lorem ipsum",
            es: "Lorem ipsum",
            ca: "Lorem ipsum"
          }
        end
        let(:duration) { 2.days.from_now }
        let(:included_at) { 2.days.from_now }
        let(:closing_date) { 2.days.from_now }
        let(:closing_date_reason) do
          {
            en: "Closing date reason",
            es: "Razón cierre",
            ca: "Raó tancament"
          }
        end
        let(:internal_organisation) do
          {
            en: "Internal organisation",
            es: "Organización interna",
            ca: "Organització interna"
          }
        end
        let(:is_transparent) { true }
        let(:special_features) do
          {
            en: "Special features",
            es: "Caracterísitcas especiales",
            ca: "Característiques especials"
          }
        end
        let(:twitter_handler) { "lorem" }
        let(:facebook_handler) { "lorem" }
        let(:instagram_handler) { "lorem" }
        let(:youtube_handler) { "lorem" }
        let(:github_handler) { "lorem" }
        let(:announcement) do
          {
            en: "Announcement",
            es: "Anuncio",
            ca: "Anunci"
          }
        end
        let(:parent_id) { nil }
        let(:assembly_id) { nil }
        let(:ceco) { "ceco" }
        let(:ceco_txt) { "ceco_txt" }
        let(:grup_empleados) { "grup_empleados" }
        let(:estat_soci) { "estat_soci" }
        let(:tipologia) { "tipologia" }
        let(:derechovoto) { "derechovoto" }

        let(:attributes) do
          {
            "assembly" => {
              "title_en" => title[:en],
              "title_es" => title[:es],
              "title_ca" => title[:ca],
              "subtitle_en" => subtitle[:en],
              "subtitle_es" => subtitle[:es],
              "subtitle_ca" => subtitle[:ca],
              "description_en" => description[:en],
              "description_es" => description[:es],
              "description_ca" => description[:ca],
              "short_description_en" => short_description[:en],
              "short_description_es" => short_description[:es],
              "short_description_ca" => short_description[:ca],
              "hero_image" => attachment,
              "banner_image" => attachment,
              "slug" => slug,
              "show_statistics" => show_statistics,
              "private_space" => private_space,
              "purpose_of_action_en" => purpose_of_action[:en],
              "purpose_of_action_es" => purpose_of_action[:es],
              "purpose_of_action_ca" => purpose_of_action[:ca],
              "decidim_assemblies_type_id" => assembly_type_id,
              "creation_date" => creation_date,
              "created_by" => created_by,
              "created_by_other_en" => created_by_other[:en],
              "created_by_other_es" => created_by_other[:es],
              "created_by_other_ca" => created_by_other[:ca],
              "duration" => duration,
              "included_at" => included_at,
              "closing_date" => closing_date,
              "closing_date_reason_en" => closing_date_reason[:en],
              "closing_date_reason_es" => closing_date_reason[:es],
              "closing_date_reason_ca" => closing_date_reason[:ca],
              "internal_organisation_en" => internal_organisation[:en],
              "internal_organisation_es" => internal_organisation[:es],
              "internal_organisation_ca" => internal_organisation[:ca],
              "is_transparent" => is_transparent,
              "special_features_en" => special_features[:en],
              "special_features_es" => special_features[:es],
              "special_features_ca" => special_features[:ca],
              "twitter_handler" => twitter_handler,
              "facebook_handler" => facebook_handler,
              "instagram_handler" => instagram_handler,
              "youtube_handler" => youtube_handler,
              "github_handler" => github_handler,
              "weight" => weight,
              "parent_id" => parent_id,
              "ceco" => ceco,
              "ceco_txt" => ceco_txt,
              "grup_empleados" => grup_empleados,
              "estat_soci" => estat_soci,
              "tipologia" => tipologia,
              "derechovoto" => derechovoto,
              "announcement_en" => announcement[:en],
              "announcement_es" => announcement[:es],
              "announcement_ca" => announcement[:ca]
            }
          }
        end

        context "when everything is OK" do
          it { is_expected.to be_valid  }
        end

        context "when suara custom fields are empty is OK" do
          let(:ceco) { "" }
          let(:ceco_txt) { "" }
          let(:grup_empleados) { "" }
          let(:estat_soci) { "" }
          let(:tipologia) { "" }
          let(:derechovoto) { "" }

          it { is_expected.to be_valid  }
        end
      end
    end
  end
end
