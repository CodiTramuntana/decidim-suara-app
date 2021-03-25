# frozen_string_literal: true

module FilterParticipatorySpacesHelper
  def permissions(participatory_spaces)
    user_auth = Decidim::Authorization.find_by(decidim_user_id: current_user)
    user_permissions = user_auth.present? && user_auth.metadata.present? ? user_auth.metadata : {}

    without_permissions(participatory_spaces) + filter_by_permissions(participatory_spaces, user_permissions)
  end

  def without_permissions(participatory_spaces)
    participatory_spaces.select { |space| query_permissions(space) }
  end

  def filter_by_permissions(participatory_spaces, user_permissions)
    with_permissions = participatory_spaces.reject { |space| query_permissions(space) }

    if with_permissions.present?
      with_permissions = with_permissions.select do |space|
        # space permissions should be a subgroup of user permissions (ignoring empty keys)
        space.suara_permissions.delete_if { |_k, v| v.nil? || v.blank? } <= user_permissions&.delete_if { |_k, v| v.nil? || v.blank? }
      end
    end

    with_permissions
  end

  def query_permissions(space)
    space.suara_permissions.nil? || space.suara_permissions.values.all?(&:blank?)
  end
end
