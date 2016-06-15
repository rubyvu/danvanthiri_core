class AddRateToDanvanthiriCorePharmacies < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_pharmacies, :rate, :integer, defaut: 0
    add_column :danvanthiri_core_hospitals, :rate, :integer, defaut: 0
  end
end
