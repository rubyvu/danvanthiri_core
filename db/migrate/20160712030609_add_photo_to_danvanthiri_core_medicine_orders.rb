class AddPhotoToDanvanthiriCoreMedicineOrders < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_medicine_orders, :photo, :string
  end
end
