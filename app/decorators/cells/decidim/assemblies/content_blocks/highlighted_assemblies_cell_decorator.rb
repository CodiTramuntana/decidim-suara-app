# frozen_string_literal: true

# This decorator filter assemblies by permissions in home content block.
Decidim::Assemblies::ContentBlocks::HighlightedAssembliesCell.class_eval do
  include SuaraPermissionsSupervisor

  alias_method :original_highlighted_assemblies, :highlighted_assemblies

  def highlighted_assemblies
    @highlighted_assemblies ||= if current_user&.admin?
                                  original_highlighted_assemblies
                                else
                                  filter_by_suara_permissions(original_highlighted_assemblies)
                                end
  end
end
