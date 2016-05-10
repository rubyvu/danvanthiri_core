class CreateDanvanthiriCoreAmbulanceServicesCategories < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_ambulance_services_categories do |t|
      t.integer :ambulance_service_id
      t.integer :ambulance_category_id

      t.timestamps null: false
    end
  end
end
