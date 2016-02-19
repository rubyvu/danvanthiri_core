class CreateDhanvantriCoreDoctorsServices < ActiveRecord::Migration
  def change
    create_table :dhanvantri_core_doctors_services do |t|
      t.belongs_to :dhanvantri_core_doctor, foreign_key: true
      t.belongs_to :dhanvantri_core_service, foreign_key: true

      t.timestamps null: false
    end
  end
end
