# frozen_string_literal: true

# This decorator change the behavior of the consultations
# to check permissions if you are not an admin user.
Decidim::Comments::CommentsController.class_eval do
  include SuaraPermissionsSupervisor

  alias_method :original_create, :create

  def create
    return render status: :forbidden unless suara_permissions_match?(current_user, commentable.participatory_space)
    original_create
  end

  private
end
