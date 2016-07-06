class ChangeStatusDefault < ActiveRecord::Migration
  def change
    def up
      change_column_default(:danvanthiri_core_invoices, :status, 0)
    end

    def down
      change_column_default(:danvanthiri_core_invoices, :status, nil)
    end
  end
end
