# frozen_string_literal: true

# This decorator add suara permissions fields to update assembly command
Decidim::Assemblies::Admin::UpdateAssembly.class_eval do
  def attributes
    {
      title: form.title,
      subtitle: form.subtitle,
      slug: form.slug,
      hashtag: form.hashtag,
      promoted: form.promoted,
      description: form.description,
      short_description: form.short_description,
      scopes_enabled: form.scopes_enabled,
      scope: form.scope,
      area: form.area,
      parent: form.parent,
      private_space: form.private_space,
      developer_group: form.developer_group,
      local_area: form.local_area,
      target: form.target,
      participatory_scope: form.participatory_scope,
      participatory_structure: form.participatory_structure,
      meta_scope: form.meta_scope,
      show_statistics: form.show_statistics,
      purpose_of_action: form.purpose_of_action,
      composition: form.composition,
      assembly_type: form.assembly_type,
      creation_date: form.creation_date,
      created_by: form.created_by,
      created_by_other: form.created_by_other,
      duration: form.duration,
      included_at: form.included_at,
      closing_date: form.closing_date,
      closing_date_reason: form.closing_date_reason,
      internal_organisation: form.internal_organisation,
      is_transparent: form.is_transparent,
      special_features: form.special_features,
      twitter_handler: form.twitter_handler,
      facebook_handler: form.facebook_handler,
      instagram_handler: form.instagram_handler,
      youtube_handler: form.youtube_handler,
      github_handler: form.github_handler,
      weight: form.weight,
      ceco: form.ceco,
      ceco_txt: form.ceco_txt,
      tipologia: form.tipologia,
      grup_empleados: form.grup_empleados,
      estat_soci: form.estat_soci,
      derechovoto: form.derechovoto,
      estat_ocup: form.estat_ocup
    }.merge(uploader_attributes)
  end
end
