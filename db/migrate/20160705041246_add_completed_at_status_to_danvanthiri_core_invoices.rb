class AddCompletedAtStatusToDanvanthiriCoreInvoices < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_invoices, :status, :integer, default: true
    add_column :danvanthiri_core_invoices, :completed_at, :datetime, default: nil
  end
end
