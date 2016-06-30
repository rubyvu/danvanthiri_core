class RemoveDoctorOrdersLineItems < ActiveRecord::Migration
  def change
    drop_table :doctor_orders
    drop_table :doctor_line_items
  end
end
