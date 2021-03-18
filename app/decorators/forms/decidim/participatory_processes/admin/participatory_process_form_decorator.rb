# frozen_string_literal: true

# This decorator add suara permissions fields to participatory processes form
Decidim::ParticipatoryProcesses::Admin::ParticipatoryProcessForm.class_eval do
  attribute :suara_permissions, String
  attribute :ceco, String
  attribute :ceco_txt, String
  attribute :tipologia, String
  attribute :grup_empleados, String
  attribute :estat_soci, String
  attribute :derechovoto, String
  attribute :estat_ocup, String
end
