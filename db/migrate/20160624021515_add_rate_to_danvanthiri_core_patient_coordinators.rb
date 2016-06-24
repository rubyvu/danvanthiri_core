class AddRateToDanvanthiriCorePatientCoordinators < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_patient_coordinators, :rate, :integer, default: 0
  end
end
