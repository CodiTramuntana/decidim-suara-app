# frozen_string_literal: true

# This decorator changes the visible_for query from assembly to remove the action distinct over the query
Decidim::Assembly.class_eval do
  # Overwriting existing method Decidim::HasPrivateUsers.visible_for
  def self.visible_for(user)
    if user
      return all if user.admin?

      left_outer_joins(:participatory_space_private_users).where(
        %{private_space = false OR
        (private_space = true AND is_transparent = true) OR
        decidim_participatory_space_private_users.decidim_user_id = ?}, user.id
      )
    else
      public_spaces
    end
  end  
end
