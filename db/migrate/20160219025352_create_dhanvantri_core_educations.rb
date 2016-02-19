class CreateDhanvantriCoreEducations < ActiveRecord::Migration
  def change
    create_table :dhanvantri_core_educations do |t|
      t.belongs_to :doctor, index: true, foreign_key: true
      t.string :certification
      t.string :college
      t.integer :year

      t.timestamps null: false
    end
  end
end
