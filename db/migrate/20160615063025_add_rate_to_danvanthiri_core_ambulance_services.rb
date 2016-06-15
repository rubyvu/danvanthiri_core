class AddRateToDanvanthiriCoreAmbulanceServices < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_ambulance_services, :rate, :integer, default: 0
  end
end
