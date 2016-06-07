class RemovePatientIdFromPharmacyCategories < ActiveRecord::Migration
  def change
    remove_column :danvanthiri_core_pharmacy_categories, :patient_id
  end
end
