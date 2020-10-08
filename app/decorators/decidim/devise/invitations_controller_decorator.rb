# frozen_string_literal: true

# This decorator changes the redirect destination after a user register from an invitations
Decidim::Devise::InvitationsController.class_eval do

  def after_accept_path_for(resource)
    root_url
  end

end
