class CreateDanvanthiriCoreDonors < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_donors do |t|
      t.integer :patient_id
      t.string :category
      t.string :sub_category
      t.string :blood_group
      t.datetime :date_of_birth

      t.timestamps null: false
    end
  end
end
