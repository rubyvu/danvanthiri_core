class AddPatientCoordinatorToDanvanthiriCoreAppointments < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_appointments, :patient_coordinator_id, :integer
    add_index :danvanthiri_core_appointments, :patient_coordinator_id
  end
end
