class AddDeliveryTimeToDanvanthiriCoreMedicineOrders < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_medicine_orders, :delivery_time, :datetime
  end
end
