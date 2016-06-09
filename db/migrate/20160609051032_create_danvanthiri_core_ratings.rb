class CreateDanvanthiriCoreRatings < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_ratings do |t|
      t.integer :owner_id
      t.string :owner_type
      t.integer :rateable_id
      t.string :rateable_type
      t.integer :rate, default: 0
      t.text :review

      t.timestamps null: false
    end

    remove_column :danvanthiri_core_pharmacies, :is_favourite
    remove_column :danvanthiri_core_pharmacies, :star
    rename_column :danvanthiri_core_pharmacies, :rating, :rate
  end
end
