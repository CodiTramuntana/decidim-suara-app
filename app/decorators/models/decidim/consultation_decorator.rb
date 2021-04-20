# frozen_string_literal: true

# This decorator add suara permissions field with the keys to consultations model
Decidim::Consultation.class_eval do
  store_accessor :suara_permissions, :ceco, :ceco_txt, :tipologia, :grup_empleados, :estat_soci,
                 :derechovoto, :estat_ocup
end
