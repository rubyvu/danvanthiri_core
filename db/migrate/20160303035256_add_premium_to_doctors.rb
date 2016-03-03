class AddPremiumToDoctors < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_doctors, :premium, :boolean, default: false
  end
end
