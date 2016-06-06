class CreateDanvanthiriCorePharmacyCategories < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_pharmacy_categories do |t|
      t.string :name
      t.string :icon
      t.string :banner
      t.integer :patient_id

      t.timestamps null: false
    end
  end
end
