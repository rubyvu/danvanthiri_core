class AddBannerToDanvanthiriCoreAmbulanceServices < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_ambulance_services, :banner, :string
    add_column :danvanthiri_core_ambulance_services, :premium, :boolean
  end
end
