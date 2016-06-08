class CreateJoinTablePharmacyCategoryPharmacy < ActiveRecord::Migration
  def change
    create_join_table :danvanthiri_core_pharmacy_categories, :danvanthiri_core_pharmacies do |t|
      t.index [:pharmacy_category_id, :pharmacy_id], name: "index_on_pharmacy_category_id_and_pharmacy_id"
      t.index [:pharmacy_id, :pharmacy_category_id], name: "index_on_pharmacy_id_and_pharmacy_category_id"
    end
  end
end
