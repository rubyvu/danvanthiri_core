class AddMoreFieldsToDanvanthiriCoreDoctors < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_doctors, :payment_method, :integer
    add_column :danvanthiri_core_doctors, :verified, :boolean, default: false
    add_column :danvanthiri_core_doctors, :auto_accept_booking, :boolean, default: false
  end
end
