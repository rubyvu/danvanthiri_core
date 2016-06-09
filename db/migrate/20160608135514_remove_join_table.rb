class RemoveJoinTable < ActiveRecord::Migration
  def change
  	drop_join_table :danvanthiri_core_pharmacy_categories, :danvanthiri_core_pharmacies
  end
end
