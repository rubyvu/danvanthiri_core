class CreateDanvanthiriCoreInvoiceItems < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_invoice_items do |t|
      t.references :invoice
      t.integer    :quantity,                               :null => false
      t.decimal    :price,    :precision => 8, :scale => 2, :null => false
      t.string     :currency, :string
      t.timestamps null: false
    end
  end
end
