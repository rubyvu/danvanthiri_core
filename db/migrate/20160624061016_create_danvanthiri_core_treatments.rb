class CreateDanvanthiriCoreTreatments < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_treatments do |t|
      t.integer :quotation_id
      t.string :name
      t.integer :price

      t.timestamps null: false
    end
  end
end
