# frozen_string_literal: true

# This decorator change the behavior of the promoted and parent assemblies
# to check permissions if you are not an admin user.
Decidim::Assemblies::AssembliesController.class_eval do
  include FilterParticipatorySpacesHelper

  def promoted_assemblies
    if current_user.admin?
      @promoted_assemblies ||= published_assemblies | Decidim::Assemblies::PromotedAssemblies.new
    else
      promoted_assemblies ||= published_assemblies | Decidim::Assemblies::PromotedAssemblies.new
      @promoted_assemblies = Decidim::Assembly.where(id: permissions(promoted_assemblies).map(&:id)).order(weight: :asc)
    end
  end

  def parent_assemblies
    if current_user.admin?
      search.results.parent_assemblies.order(weight: :asc, promoted: :desc)
    else
      @promoted_assemblies = Decidim::Assembly.where(id: permissions(search.results.parent_assemblies).map(&:id)).order(weight: :asc, promoted: :desc)
    end
  end
end
