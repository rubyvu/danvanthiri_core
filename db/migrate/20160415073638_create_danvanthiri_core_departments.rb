class CreateDanvanthiriCoreDepartments < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_departments do |t|
      t.integer :hospital_id
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
