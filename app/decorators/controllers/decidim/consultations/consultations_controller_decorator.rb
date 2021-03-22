# frozen_string_literal: true

# This decorator change the behavior of the consultations
# to check permissions if you are not an admin user.
Decidim::Consultations::ConsultationsController.class_eval do
  include FilterParticipatorySpacesHelper

  def consultations
    if current_user.present?
      if current_user.admin?
        consultation_results
      else
        @consultations = permissions(reorder(search.results))
        @consultations = Decidim::Consultation.where(id: @consultations.map(&:id))
        @consultations = paginate(@consultations)
      end
    else
      consultation_results
    end
  end

  def consultation_results
    @consultations = search.results
    @consultations = reorder(@consultations)
    @consultations = paginate(@consultations)
  end
end
