class CreateDanvanthiriCorePcPlans < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_pc_plans do |t|
      t.string :name
      t.integer :unit_price
      t.string :image
      t.text :description
      t.boolean :fixed_price

      t.timestamps null: false
    end
  end
end
