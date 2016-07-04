class AddIosDeviceTokenToPatientsAndDoctors < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_doctors, :ios_device_token, :string
    add_column :danvanthiri_core_patients, :ios_device_token, :string
  end
end
