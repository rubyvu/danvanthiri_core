class CreateDanvanthiriCoreQuotations < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_quotations do |t|
      t.integer :owner_id
      t.string :owner_type
      t.integer :pharmacy_id
      t.string :photo

      t.timestamps null: false
    end
  end
end
