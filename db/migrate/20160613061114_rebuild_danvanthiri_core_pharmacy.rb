class RebuildDanvanthiriCorePharmacy < ActiveRecord::Migration
  def change
    drop_table :danvanthiri_core_pharmacies
    drop_table :danvanthiri_core_pharmacy_category_pharmacies
    create_table :danvanthiri_core_pharmacies do |t|
      t.string :name
      t.string :email
      t.string :logo
      t.string :mobile_number
      t.integer :pharmacy_category_id
      t.boolean :home_delivery
      t.string :certification
      t.string :license
      t.text :about
      t.string :addr_street
      t.string :addr_area
      t.string :addr_city
      t.string :addr_state
      t.float :lat
      t.float :lng

      t.timestamps null: false
    end
  end
end
