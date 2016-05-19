class CreateDanvanthiriCoreRecognitions < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_recognitions do |t|
      t.integer :owner_id
      t.string :owner_type
      t.string :name

      t.timestamps null: false
    end
  end
end
