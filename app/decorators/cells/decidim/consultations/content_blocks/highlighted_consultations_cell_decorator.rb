# frozen_string_literal: true

# This decorator filter consultations by permissions in home content block.
Decidim::Consultations::ContentBlocks::HighlightedConsultationsCell.class_eval do
  include FilterParticipatorySpacesHelper

  def highlighted_consultations
    @highlighted_consultations ||= if current_user.admin?
                                     Decidim::Consultations::OrganizationActiveConsultations
                                       .new(current_organization)
                                       .query
                                       .limit(max_results)
                                   else
                                     permissions(Decidim::Consultations::OrganizationActiveConsultations
                                      .new(current_organization)
                                      .query
                                      .limit(max_results))
                                   end
  end
end
