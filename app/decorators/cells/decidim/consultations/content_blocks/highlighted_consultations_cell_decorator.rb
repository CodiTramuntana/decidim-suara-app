# frozen_string_literal: true

# This decorator filter consultations by permissions in home content block.
Decidim::Consultations::ContentBlocks::HighlightedConsultationsCell.class_eval do
  include FilterParticipatorySpacesHelper

  alias_method :original_highlighted_consultations, :highlighted_consultations

  def highlighted_consultations
    @highlighted_consultations ||= if current_user.admin?
                                     original_highlighted_consultations
                                   else
                                     permissions(original_highlighted_consultations)
                                   end
  end
end
