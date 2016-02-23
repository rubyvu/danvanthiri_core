class CreateDanvanthiriCoreDoctorsServices < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_doctors_services do |t|
      t.belongs_to :doctor
      t.belongs_to :service

      t.timestamps null: false
    end
  end
end
