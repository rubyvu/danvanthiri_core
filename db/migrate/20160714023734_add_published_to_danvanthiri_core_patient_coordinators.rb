class AddPublishedToDanvanthiriCorePatientCoordinators < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_patient_coordinators, :published, :boolean, default: false
  end
end
