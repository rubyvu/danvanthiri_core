class CreateJoinTablePharmacyCategoryPharmacy < ActiveRecord::Migration
  def change
    create_join_table :danvanthiri_core_pharmacy_categories, :danvanthiri_core_pharmacies do |t|
  
    end
  end
end
