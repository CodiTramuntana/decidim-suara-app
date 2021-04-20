class AddSuaraPermissionToParticipatoryProcesses < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_participatory_processes, :suara_permissions, :jsonb
  end
end
