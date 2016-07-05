class AddCityAndAreaToDanvanthiriCorePatientCoordinatorsPcplans < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_patient_coordinators_pcplans, :city_number, :integer
    add_column :danvanthiri_core_patient_coordinators_pcplans, :area_number, :integer
  end
end
