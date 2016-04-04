class CreateDanvanthiriCorePlans < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_plans do |t|
      t.string :name
      t.integer :unit_price
      t.string :logo
      t.text :description

      t.timestamps null: false
    end
  end
end
