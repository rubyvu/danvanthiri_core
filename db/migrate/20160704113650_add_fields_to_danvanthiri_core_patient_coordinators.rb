class AddFieldsToDanvanthiriCorePatientCoordinators < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_patient_coordinators, :gender, :integer
    add_column :danvanthiri_core_patient_coordinators, :last_name, :string
    rename_column :danvanthiri_core_patient_coordinators, :name, :first_name
    add_column :danvanthiri_core_patient_coordinators, :addr_street, :string
    add_column :danvanthiri_core_patient_coordinators, :addr_area, :string
    add_column :danvanthiri_core_patient_coordinators, :addr_city, :string
    add_column :danvanthiri_core_patient_coordinators, :addr_state, :string
  end
end
