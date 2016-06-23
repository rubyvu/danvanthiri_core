class CreateDanvanthiriCorePatientCoordinatorCategoriesCoordinators < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_patient_coordinator_categories_coordinators do |t|
      t.integer :patient_coordinator_category_id
      t.integer :patient_coordinator_id

      t.timestamps null: false
    end
  end
end
