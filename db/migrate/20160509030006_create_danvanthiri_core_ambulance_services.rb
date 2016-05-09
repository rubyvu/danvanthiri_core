class CreateDanvanthiriCoreAmbulanceServices < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_ambulance_services do |t|
      t.string :name
      t.string :mobile
      t.text :about
      t.integer :year_of_establishment
      t.string :area
      t.string :logo

      t.timestamps null: false
    end
  end
end
