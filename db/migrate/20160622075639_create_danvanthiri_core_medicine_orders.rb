class CreateDanvanthiriCoreMedicineOrders < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_medicine_orders do |t|
      t.integer :owner_id
      t.string :owner_type
      t.integer :orderable_id
      t.string :orderable_type
      t.string :first_name
      t.string :last_name
      t.string :addr_line_1
      t.string :addr_line_2
      t.string :addr_city
      t.string :addr_state
      t.string :addr_pin
      t.string :phone_number
      t.integer :status

      t.timestamps null: false
    end
  end
end
