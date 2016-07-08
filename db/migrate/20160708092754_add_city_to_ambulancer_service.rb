class AddCityToAmbulancerService < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_ambulance_services, :city, :string
  end
end
