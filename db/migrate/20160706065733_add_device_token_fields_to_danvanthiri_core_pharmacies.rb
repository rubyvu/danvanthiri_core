class AddDeviceTokenFieldsToDanvanthiriCorePharmacies < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_pharmacies, :gcm_registration, :string
    add_column :danvanthiri_core_pharmacies, :ios_device_token, :string
  end
end
