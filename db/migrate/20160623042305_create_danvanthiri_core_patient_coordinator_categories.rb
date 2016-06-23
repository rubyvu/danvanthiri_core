class CreateDanvanthiriCorePatientCoordinatorCategories < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_patient_coordinator_categories do |t|
      t.string :name
      t.string :icon

      t.timestamps null: false
    end
  end
end
