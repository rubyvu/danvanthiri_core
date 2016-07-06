class ChangeStatusDefault < ActiveRecord::Migration
  def change
    change_column_default(:danvanthiri_core_invoices, :status, 0)
  end
end
