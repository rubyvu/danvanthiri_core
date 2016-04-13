class CreateDanvanthiriCoreHospitals < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_hospitals do |t|
      t.string :name
      t.string :logo
      t.string :addr_street
      t.string :addr_area
      t.string :addr_city
      t.string :addr_state
      t.string :phone_number
      t.float :lat
      t.float :lng
      t.boolean :active, deafult: false

      t.timestamps null: false
    end
  end
end
