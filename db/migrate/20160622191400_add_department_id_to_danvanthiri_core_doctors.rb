class AddDepartmentIdToDanvanthiriCoreDoctors < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_doctors, :department_id, :integer
    add_column :danvanthiri_core_appointments, :hospital_id, :integer
    add_column :danvanthiri_core_appointments, :department_id, :integer
    add_column :danvanthiri_core_appointments, :book_type, :integer, default: 0
  end
end
