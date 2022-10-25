# frozen_string_literal: true

module Decidim
  module Consultations
    class ExportConsultationParticipantsJob < ApplicationJob
      queue_as :default

      def perform(user, consultation)
        @consultation = consultation

        export_data = Decidim::Exporters
                      .find_exporter("CSV")
                      .new(collection, serializer)
                      .export

        Decidim::ExportMailer.export(user, filename, export_data).deliver_now
      end

      private

      attr_reader :consultation

      def collection
        if consultation.active?
          []
        else
          Decidim::Consultations::Participation.new(consultation).results
        end
      end

      def serializer
        ConsultationParticipantsSerializer
      end

      def filename
        I18n.t("decidim.admin.consultations.participants.export_filename")
      end
    end
  end
end
