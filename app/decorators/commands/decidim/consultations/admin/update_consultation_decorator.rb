# frozen_string_literal: true

# This decorator add suara permissions fields to update consultation command
Decidim::Consultations::Admin::UpdateConsultation.class_eval do
  def attributes
    {
      title: form.title,
      subtitle: form.subtitle,
      description: form.description,
      slug: form.slug,
      highlighted_scope: form.highlighted_scope,
      introductory_video_url: form.introductory_video_url,
      start_voting_date: form.start_voting_date,
      end_voting_date: form.end_voting_date,
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
