class AddStatusToDanvanthiriCoreQuotations < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_quotations, :status, :integer, default: 0
  end
end
