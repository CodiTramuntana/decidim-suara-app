class AddSuaraPermissionToAssemblies < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_assemblies, :suara_permissions, :jsonb
  end
end
