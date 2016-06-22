class CreateDanvanthiriCoreOrderItems < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_medicine_order_items do |t|
      t.integer :medicine_order_id
      t.string :medicine_name
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
