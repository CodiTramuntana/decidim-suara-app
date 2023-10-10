# frozen_string_literal: true

# This Supervisor checks User's permissions from SAP.
module SuaraPermissionsSupervisor
  # Checks whether the given `user` has the same permissions as the given `participatory_space`.
  def suara_permissions_match?(user, participatory_space)
    user_auth = Decidim::Authorization.find_by(decidim_user_id: user.id, name: "sap_authorization_handler")
    user_permissions = user_auth&.metadata || {}
    space_permissions= participatory_space.suara_permissions
    # space permissions should be a subgroup of user permissions (ignoring empty keys)
    space_permissions.delete_if { |_k, v| v.nil? || v.blank? } <= user_permissions&.delete_if { |_k, v| v.nil? || v.blank? }
  end

  def filter_by_suara_permissions(participatory_spaces)
    user_auth = Decidim::Authorization.find_by(decidim_user_id: current_user)
    user_permissions = user_auth.present? && user_auth.metadata.present? ? user_auth.metadata : {}

    without_permissions(participatory_spaces) + filter_by_permissions(participatory_spaces, user_permissions)
  end

  def without_permissions(participatory_spaces)
    participatory_spaces.select { |space| blank_permissions?(space) }
  end

  def filter_by_permissions(participatory_spaces, user_permissions)
    with_permissions = participatory_spaces.reject { |space| blank_permissions?(space) }

    if with_permissions.present?
      with_permissions = with_permissions.select do |space|
        # space permissions should be a subgroup of user permissions (ignoring empty keys)
        space.suara_permissions.delete_if { |_k, v| v.nil? || v.blank? } <= user_permissions&.delete_if { |_k, v| v.nil? || v.blank? }
      end
    end

    with_permissions
  end

  def blank_permissions?(space)
    space.suara_permissions.nil? || space.suara_permissions.values.all?(&:blank?)
  end

  # ----------------------------------------------------------------

  private

  # ----------------------------------------------------------------

  def admin_or_with_suara_permissions?(user, participatory_space)
    return false unless user

    user.admin? || suara_permissions_match?(user, participatory_space)
  end
end
