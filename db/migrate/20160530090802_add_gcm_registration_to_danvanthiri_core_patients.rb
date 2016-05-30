class AddGcmRegistrationToDanvanthiriCorePatients < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_patients, :gcm_registration, :string
    add_column :danvanthiri_core_doctors, :gcm_registration, :string
  end
end
