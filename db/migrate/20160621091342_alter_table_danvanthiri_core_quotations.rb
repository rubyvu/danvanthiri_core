class AlterTableDanvanthiriCoreQuotations < ActiveRecord::Migration
  def change
    rename_column :danvanthiri_core_quotations, :pharmacy_id, :quoteable_id
    add_column :danvanthiri_core_quotations, :quoteable_type, :string
    add_column :danvanthiri_core_quotations, :total_price, :integer
    add_column :danvanthiri_core_quote_items, :price, :integer
  end
end
