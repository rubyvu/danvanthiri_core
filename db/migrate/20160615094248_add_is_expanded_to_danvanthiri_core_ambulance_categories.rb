class AddIsExpandedToDanvanthiriCoreAmbulanceCategories < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_ambulance_categories, :is_expanded, :boolean, default: false
  end
end
