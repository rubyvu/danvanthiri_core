class RemoveDoctorOrdersLineItems < ActiveRecord::Migration
  def change
    drop_table :danvanthiri_core_doctor_orders
    drop_table :danvanthiri_core_doctor_line_items
  end
end
