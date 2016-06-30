class AddPlanToInvoiceItems < ActiveRecord::Migration
  def change
    add_reference :danvanthiri_core_invoice_items, :plan
  end
end
