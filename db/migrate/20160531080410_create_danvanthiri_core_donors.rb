class CreateDanvanthiriCoreDonors < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_donors do |t|
      t.integer :patient_id
      t.integer :category
      t.integer :sub_category
      t.integer :blood_group
      t.integer :age
      t.integer :bmi

      t.timestamps null: false
    end
  end
end
