class CreateDanvanthiriCoreLabs < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_labs do |t|
      t.string :name
      t.string :email
      t.string :mobile_number
      t.string :phone_number
      t.string :logo
      t.integer :lab_category_id
      t.boolean :premium
      t.string :banner, default: false
      t.boolean :home_collection
      t.string :licence_number
      t.string :addr_street
      t.string :addr_area
      t.string :addr_city
      t.string :addr_state
      t.floar :lat
      t.float :lng
      t.integer :rate
      t.integer  :built_year
      t.boolean :verified, default: false
      t.boolean :sunday, default: true
      t.boolean :monday, default: true
      t.boolean :tuesday, default: true
      t.boolean :wednesday, default: true
      t.boolean :thursday, default: true
      t.boolean :friday, default: true
      t.boolean :saturday, default: true

      t.timestamps null: false
    end
  end
end
