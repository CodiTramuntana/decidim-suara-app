# frozen_string_literal: true

Decidim::Consultations::Admin::ConsultationForm.class_eval do
  # Add Suara permissions fields to consultations form
  attribute :ceco, String
  attribute :ceco_txt, String
  attribute :tipologia, String
  attribute :grup_empleados, String
  attribute :estat_soci, String
  attribute :derechovoto, String
  attribute :estat_ocup, String

  # Change voting dates to TimeWithZone
  attribute :start_voting_date, Decidim::Attributes::TimeWithZone
  attribute :end_voting_date, Decidim::Attributes::TimeWithZone
end
