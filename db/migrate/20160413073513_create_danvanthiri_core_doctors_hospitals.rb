class CreateDanvanthiriCoreDoctorsHospitals < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_doctors_hospitals do |t|
      t.integer :doctor_id
      t.integer :hospital_id

      t.timestamps null: false
    end
  end
end
