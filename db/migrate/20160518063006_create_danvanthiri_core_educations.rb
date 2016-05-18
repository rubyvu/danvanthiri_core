class CreateDanvanthiriCoreEducations < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_educations do |t|
      t.integer :owner_id
      t.string :owner_type
      t.string :school_name
      t.string :course
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps null: false
    end
  end
end
