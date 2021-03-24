# frozen_string_literal: true

# This decorator add suara permissions fields to consultations form
Decidim::Consultations::Admin::ConsultationForm.class_eval do
  attribute :ceco, String
  attribute :ceco_txt, String
  attribute :tipologia, String
  attribute :grup_empleados, String
  attribute :estat_soci, String
  attribute :derechovoto, String
  attribute :estat_ocup, String
end
