class AddAvailableAllToDanvanthiriCorePharmacies < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_pharmacies, :available_247, :boolean, default: false
  end
end
