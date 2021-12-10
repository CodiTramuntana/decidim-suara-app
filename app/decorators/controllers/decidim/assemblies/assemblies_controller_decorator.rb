# frozen_string_literal: true

# This decorator change the behavior of the promoted and parent assemblies
# to check permissions if you are not an admin user.
Decidim::Assemblies::AssembliesController.class_eval do
  include FilterParticipatorySpacesHelper

  private

  alias_method :original_promoted_assemblies, :promoted_assemblies
  alias_method :original_parent_assemblies, :parent_assemblies

  def promoted_assemblies
    if current_user&.admin?
      original_promoted_assemblies
    else
      @promoted_assemblies = Decidim::Assembly.where(id: permissions(original_promoted_assemblies).map(&:id)).order(weight: :asc)
    end
  end

  def parent_assemblies
    if current_user&.admin?
      original_parent_assemblies
    else
      @promoted_assemblies = Decidim::Assembly.where(id: permissions(original_parent_assemblies).map(&:id)).order(weight: :asc, promoted: :desc)
    end
  end
end
