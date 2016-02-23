class CreateDanvanthiriCoreEducations < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_educations do |t|
      t.belongs_to :doctor, index: true
      t.string :certification
      t.string :college
      t.integer :year

      t.timestamps null: false
    end
  end
end
