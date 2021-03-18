# frozen_string_literal: true

# This decorator add suara permissions fields to create participatory process command
Decidim::ParticipatoryProcesses::Admin::CreateParticipatoryProcess.class_eval do
  def create_participatory_process
    @process = Decidim::ParticipatoryProcess.new(
      organization: form.current_organization,
      title: form.title,
      subtitle: form.subtitle,
      weight: form.weight,
      slug: form.slug,
      hashtag: form.hashtag,
      description: form.description,
      short_description: form.short_description,
      hero_image: form.hero_image,
      banner_image: form.banner_image,
      promoted: form.promoted,
      scopes_enabled: form.scopes_enabled,
      scope: form.scope,
      scope_type_max_depth: form.scope_type_max_depth,
      private_space: form.private_space,
      developer_group: form.developer_group,
      local_area: form.local_area,
      area: form.area,
      target: form.target,
      participatory_scope: form.participatory_scope,
      participatory_structure: form.participatory_structure,
      meta_scope: form.meta_scope,
      start_date: form.start_date,
      end_date: form.end_date,
      participatory_process_group: form.participatory_process_group,
      ceco: form.ceco,
      ceco_txt: form.ceco_txt,
      tipologia: form.tipologia,
      grup_empleados: form.grup_empleados,
      estat_soci: form.estat_soci,
      derechovoto: form.derechovoto,
      estat_ocup: form.estat_ocup
    )

    return process unless process.valid?

    transaction do
      process.save!

      log_process_creation(process)

      process.steps.create!(
        title: Decidim::TranslationsHelper.multi_translation(
          "decidim.admin.participatory_process_steps.default_title",
          form.current_organization.available_locales
        ),
        active: true
      )

      process
    end
  end
end
