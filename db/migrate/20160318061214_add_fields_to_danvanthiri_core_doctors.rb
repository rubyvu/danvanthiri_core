class AddFieldsToDanvanthiriCoreDoctors < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_doctors, :category_id, :integer
    add_column :danvanthiri_core_doctors, :addr_pincode, :integer
    add_column :danvanthiri_core_doctors, :phone_number, :string
    add_column :danvanthiri_core_doctors, :email, :string
    add_column :danvanthiri_core_doctors, :logo, :string
    add_column :danvanthiri_core_doctors, :map_link, :string
  end
end
