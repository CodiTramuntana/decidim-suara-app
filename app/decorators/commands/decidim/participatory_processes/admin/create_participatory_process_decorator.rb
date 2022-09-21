# frozen_string_literal: true

# This decorator add suara permissions fields to create participatory process command
Decidim::ParticipatoryProcesses::Admin::CreateParticipatoryProcess.class_eval do
  alias_method :original_attributes, :attributes

  def attributes
    suara_permissions = {
      ceco: form.ceco,
      ceco_txt: form.ceco_txt,
      tipologia: form.tipologia,
      grup_empleados: form.grup_empleados,
      estat_soci: form.estat_soci,
      derechovoto: form.derechovoto,
      estat_ocup: form.estat_ocup
    }

    original_attributes.merge(suara_permissions)
  end
end
