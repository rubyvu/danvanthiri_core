class CreateDanvanthiriCoreLikes < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_likes do |t|
      t.integer :patient_id
      t.integer :likeable_id
      t.string :likeable_type

      t.timestamps null: false
    end
  end
end
