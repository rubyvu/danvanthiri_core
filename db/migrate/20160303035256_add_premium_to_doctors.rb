class AddPremiumToDoctors < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_doctors, :premium, :boolean, default: false
    add_column :danvanthiri_core_doctors, :banner, :string
  end
end
