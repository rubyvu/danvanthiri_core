class AlterTableDanvanthiriCoreMedicineOrders < ActiveRecord::Migration
  def change
    remove_column :danvanthiri_core_medicine_orders, :status
    DanvanthiriCore::MedicineOrder.destroy_all
  end
end
