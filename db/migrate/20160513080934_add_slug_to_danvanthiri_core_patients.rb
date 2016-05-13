class AddSlugToDanvanthiriCorePatients < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_patients, :slug, :string
  end
end
