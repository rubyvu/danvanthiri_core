class CreateDanvanthiriCoreActivities < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_activities do |t|
      t.integer :owner_id
      t.string :owner_type
      t.string :log_type
      t.integer :related_obj_id
      t.string :related_obj_type
      t.integer :value

      t.timestamps null: false
    end
  end
end
