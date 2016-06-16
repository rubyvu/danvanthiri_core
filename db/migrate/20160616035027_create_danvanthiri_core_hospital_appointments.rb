class CreateDanvanthiriCoreHospitalAppointments < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_hospital_appointments do |t|
      t.integer :patient_id
      t.integer :hospital_id
      t.integer :bookable_id
      t.string :bookable_type
      t.datetime :booktime
      t.datetime :endtime
      t.integer :status, default: 0
      t.integer :fee

      t.timestamps null: false
    end
  end
end
