class CreateDanvanthiriCoreEmergencies < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_emergencies do |t|
      t.integer :patient_id
      t.string :name
      t.string :email
      t.string :mobile_number
      t.string :location
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
