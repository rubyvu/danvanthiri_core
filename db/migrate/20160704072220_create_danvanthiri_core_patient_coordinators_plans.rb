class CreateDanvanthiriCorePatientCoordinatorsPcPlans < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_patient_coordinators_pc_plans do |t|
      t.integer :patient_coordinator_id
      t.integer :pc_plan_id
      t.integer :status
      t.integer :price
      t.datetime :expired_date

      t.timestamps null: false
    end
  end
end
