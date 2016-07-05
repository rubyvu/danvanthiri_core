class ChangeStatusDefault0ToInvoices < ActiveRecord::Migration
  def change
    def change
      remove_column :danvanthiri_core_invoices, :status, :integer
      add_column :danvanthiri_core_invoices, :status, :integer, default: 0
    end
  end
end
