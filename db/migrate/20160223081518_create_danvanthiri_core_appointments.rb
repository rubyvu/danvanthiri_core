class CreateDanvanthiriCoreAppointments < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_appointments do |t|
      t.belongs_to :patient, index: true
      t.belongs_to :doctor, index: true
      t.datetime :booktime
      t.integer :status, default: 0;

      t.timestamps null: false
    end
  end
end
