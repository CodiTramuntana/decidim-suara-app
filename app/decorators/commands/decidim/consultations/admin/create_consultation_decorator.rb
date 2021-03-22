# frozen_string_literal: true

# This decorator add suara permissions fields to create consultation command
Decidim::Consultations::Admin::CreateConsultation.class_eval do
  def create_consultation
    consultation = Decidim::Consultation.new(
      organization: form.current_organization,
      title: form.title,
      subtitle: form.subtitle,
      description: form.description,
      slug: form.slug,
      banner_image: form.banner_image,
      highlighted_scope: form.highlighted_scope,
      introductory_video_url: form.introductory_video_url,
      start_voting_date: form.start_voting_date,
      end_voting_date: form.end_voting_date,
      introductory_image: form.introductory_image,
      ceco: form.ceco,
      ceco_txt: form.ceco_txt,
      tipologia: form.tipologia,
      grup_empleados: form.grup_empleados,
      estat_soci: form.estat_soci,
      derechovoto: form.derechovoto,
      estat_ocup: form.estat_ocup
    )

    return consultation unless consultation.valid?

    consultation.save
    consultation
  end
end
