# frozen_string_literal: true

# This decorator change the behavior of the consultations
# to check permissions if you are not an admin user.
Decidim::Components::BaseController.class_eval do
  include SuaraPermissionsSupervisor

  before_action :check_suara_permissions

  def check_suara_permissions
    # Suara requires users to be logged in to access the contents of the platform
    # so current_user is mandatory, there are no anonymous users
    render status: :forbidden unless admin_or_with_suara_permissions?(current_user, current_participatory_space)
  end
end
