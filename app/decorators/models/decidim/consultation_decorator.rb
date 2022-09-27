# frozen_string_literal: true

Decidim::Consultation.class_eval do
  # Add Suara permissions field with the keys to consultations model
  store_accessor :suara_permissions, :ceco, :ceco_txt, :tipologia, :grup_empleados, :estat_soci,
                 :derechovoto, :estat_ocup

  # Change to Time.zone.now in voting dates queries
  scope :upcoming, -> { published.where("start_voting_date > ?", Time.zone.now) }

  scope :active, lambda {
    published
      .where("start_voting_date <= ?", Time.zone.now)
      .where("end_voting_date >= ?", Time.zone.now)
  }

  def upcoming?
    start_voting_date > Time.zone.now
  end

  def active?
    start_voting_date <= Time.zone.now && end_voting_date >= Time.zone.now
  end
end
