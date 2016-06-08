class CreateDanvanthiriCorePharmacies < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_pharmacies do |t|
      t.string :name
      t.boolean :is_favourite, deafult: false
      t.string :image
      t.string :timing
      t.datetime :start_time
      t.datetime :end_time
      t.float :latitude
      t.float :longitude
      t.string :specialization
      t.boolean :is_home_delivery, deafult: false
      t.boolean :availability, default: false
      t.string :description
      t.string :certificate
      t.string :license
      t.string :about
      t.integer :star
      t.integer :rating
      t.string :address

      t.timestamps null: false
    end
  end
end
