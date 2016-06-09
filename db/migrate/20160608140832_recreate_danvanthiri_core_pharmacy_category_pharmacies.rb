class RecreateDanvanthiriCorePharmacyCategoryPharmacies < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_pharmacy_category_pharmacies do |t|
      t.integer :pharmacy_category_id
      t.integer :pharmacy_id

      t.timestamps null: false
    end
  end
end
