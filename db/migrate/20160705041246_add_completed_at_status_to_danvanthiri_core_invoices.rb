class AddCompletedAtStatusToDanvanthiriCoreInvoices < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_invoices, :status, :integer, default: true
  end
end
