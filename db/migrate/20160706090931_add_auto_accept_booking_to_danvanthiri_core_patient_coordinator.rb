class AddAutoAcceptBookingToDanvanthiriCorePatientCoordinator < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_patient_coordinators, :auto_accept_booking, :boolean, default: false
  end
end
