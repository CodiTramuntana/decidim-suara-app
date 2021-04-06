# frozen_string_literal: true

# This decorator add suara permissions fields to update assembly command
Decidim::Assemblies::Admin::UpdateAssembly.class_eval do
  private

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
