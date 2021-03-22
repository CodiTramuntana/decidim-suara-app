class AddSuaraPermissionToConsultations < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_consultations, :suara_permissions, :jsonb
  end
end
