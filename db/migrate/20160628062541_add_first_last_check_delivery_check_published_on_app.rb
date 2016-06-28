class AddFirstLastCheckDeliveryCheckPublishedOnApp < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_pharmacies, :firstname, :string
    add_column :danvanthiri_core_pharmacies, :lastname, :string
    add_column :danvanthiri_core_pharmacies, :home_delivery, :boolean, default: false
    add_column :danvanthiri_core_pharmacies, :published_on_patient_app, :boolean, default: false
  end
end
