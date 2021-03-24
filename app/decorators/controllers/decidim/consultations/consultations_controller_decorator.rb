# frozen_string_literal: true

# This decorator change the behavior of the consultations
# to check permissions if you are not an admin user.
Decidim::Consultations::ConsultationsController.class_eval do
  include FilterParticipatorySpacesHelper

  private

  alias_method :original_consultations, :consultations

  def consultations
    if current_user.admin?
      original_consultations
    else
      @consultations = permissions(reorder(search.results))
      @consultations = Decidim::Consultation.where(id: @consultations.map(&:id))
      @consultations = paginate(@consultations)
    end
  end
end
