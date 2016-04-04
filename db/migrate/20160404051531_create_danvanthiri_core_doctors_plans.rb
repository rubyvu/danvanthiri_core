class CreateDanvanthiriCoreDoctorsPlans < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_doctors_plans do |t|
      t.integer :doctor_id
      t.integer :plan_id
      t.integer :city_number, default: 1
      t.integer :area_number, default: 1
      t.integer :status
      t.datetime :expired_date

      t.timestamps null: false
    end
  end
end
