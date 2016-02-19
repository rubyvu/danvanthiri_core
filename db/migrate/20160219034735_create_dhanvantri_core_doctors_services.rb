class CreateDhanvantriCoreDoctorsServices < ActiveRecord::Migration
  def change
    create_table :dhanvantri_core_doctors_services do |t|
      t.belongs_to :doctor
      t.belongs_to :service

      t.timestamps null: false
    end
  end
end
