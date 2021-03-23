# frozen_string_literal: true

# This decorator change the behavior of the consultations
# to check permissions if you are not an admin user.
Decidim::Consultations::ConsultationsController.class_eval do
  include FilterParticipatorySpacesHelper

  def consultations
    if current_user.admin?
      @consultations = search.results
      @consultations = reorder(@consultations)
    else
      @consultations = permissions(reorder(search.results))
      @consultations = Decidim::Consultation.where(id: @consultations.map(&:id))
    end
    @consultations = paginate(@consultations)
  end
end
