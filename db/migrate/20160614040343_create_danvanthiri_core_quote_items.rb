class CreateDanvanthiriCoreQuoteItems < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_quote_items do |t|
      t.integer :quotation_id
      t.string :medicine_name
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
