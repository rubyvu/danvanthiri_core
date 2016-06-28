class AddRefIdToDanvanthiriCoreQuotations < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_quotations, :quote_thread_id, :integer
  end
end
