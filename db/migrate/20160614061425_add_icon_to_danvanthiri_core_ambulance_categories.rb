class AddIconToDanvanthiriCoreAmbulanceCategories < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_ambulance_categories, :icon, :string
  end
end
