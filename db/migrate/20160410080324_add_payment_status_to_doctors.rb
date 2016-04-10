class AddPaymentStatusToDoctors < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_doctors, :payment_status, :integer, default: 0
    rename_column :danvanthiri_core_categories, :description, :welcome_message
    rename_column :danvanthiri_core_branches, :description, :welcome_message
  end
end
