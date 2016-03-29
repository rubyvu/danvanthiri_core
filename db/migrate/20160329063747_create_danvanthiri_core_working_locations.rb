class CreateDanvanthiriCoreWorkingLocations < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_working_locations do |t|
      t.integer :doctor_id
      t.string :name
      t.string :addr_street
      t.string :addr_area
      t.string :addr_city
      t.string :addr_state
      t.string :phone_number

      t.timestamps null: false
    end
  end
end
