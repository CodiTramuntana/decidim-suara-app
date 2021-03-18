# frozen_string_literal: true

# This decorator change the behavior of the promoted and parent assemblies
# to check permissions if you are not an admin user.
Decidim::Assemblies::AssembliesController.class_eval do
  include FilterParticipatorySpacesHelper

  def promoted_assemblies
    return [] unless current_user

    if current_user.admin?
      @promoted_assemblies ||= published_assemblies | Decidim::Assemblies::PromotedAssemblies.new
    else
      promoted_assemblies ||= published_assemblies | Decidim::Assemblies::PromotedAssemblies.new
      permissions(promoted_assemblies).sort_by(&:weight)
    end
  end

  def parent_assemblies
    return [] unless current_user

    if current_user.admin?
      search.results.parent_assemblies.order(weight: :asc, promoted: :desc)
    else
      permissions(search.results.parent_assemblies).sort_by { |a| a.promoted ? 0 : 1 }.sort_by(&:weight)
    end
  end
end
