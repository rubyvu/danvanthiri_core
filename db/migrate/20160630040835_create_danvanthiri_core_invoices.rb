class CreateDanvanthiriCoreInvoices < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_invoices do |t|
      t.string :number, :limit => 15
      t.decimal :total, :precision => 8, :scale => 2, :default => 0.0, :null => false
      t.datetime :completed_at
      t.string :email
      t.timestamps null: false
    end
  end
end
