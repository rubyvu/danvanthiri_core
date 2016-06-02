class CreateDanvanthiriCoreNotifications < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_notifications do |t|
      t.integer :owner_id
      t.string :owner_type
      t.integer :target_id
      t.string :target_type
      t.string :message

      t.timestamps null: false
    end
  end
end
