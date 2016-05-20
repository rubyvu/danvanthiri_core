class CreateDanvanthiriCoreHospitalCategories < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_hospital_categories do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
