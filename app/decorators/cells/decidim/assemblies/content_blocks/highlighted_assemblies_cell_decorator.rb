# frozen_string_literal: true

# This decorator filter assemblies by permissions in home content block.
Decidim::Assemblies::ContentBlocks::HighlightedAssembliesCell.class_eval do
  include FilterParticipatorySpacesHelper

  def highlighted_assemblies
    @highlighted_assemblies ||= if current_user.admin?
                                  Decidim::Assemblies::OrganizationPrioritizedAssemblies
                                    .new(current_organization, current_user)
                                    .query
                                    .includes([:organization])
                                    .limit(max_results)
                                else
                                  permissions(Decidim::Assemblies::OrganizationPrioritizedAssemblies
                                    .new(current_organization, current_user)
                                    .query
                                    .includes([:organization])
                                    .limit(max_results))
                                end
  end
end
