# frozen_string_literal: true

module Admin
  module Consultations
    class ParticipantsController < ::Decidim::Consultations::Admin::ApplicationController
      include ::Decidim::NeedsPermission
      include ::Decidim::Consultations::NeedsConsultation

      def export
        enforce_permission_to :update, :consultation, consultation: current_consultation

        ExportConsultationParticipantsJob.perform_later(current_user, current_consultation)

        flash[:notice] = t("decidim.admin.exports.notice")
        redirect_back(fallback_location: results_consultation_path(current_consultation))
      end
    end
  end
end
