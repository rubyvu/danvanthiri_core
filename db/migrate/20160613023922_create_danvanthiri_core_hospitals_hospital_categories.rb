class CreateDanvanthiriCoreHospitalsHospitalCategories < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_hospitals_hospital_categories do |t|
      t.integer :hospital_id
      t.integer :hospital_category_id
      t.timestamps null: false
    end
  end
end
