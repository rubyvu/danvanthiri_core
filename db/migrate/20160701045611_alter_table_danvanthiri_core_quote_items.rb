class AlterTableDanvanthiriCoreQuoteItems < ActiveRecord::Migration
  def change
    rename_column :danvanthiri_core_quote_items, :medicine_name, :name
    DanvanthiriCore::Quotation.for_hospital.destroy_all
  end
end
