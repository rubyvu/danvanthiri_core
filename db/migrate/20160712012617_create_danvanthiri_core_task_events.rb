class CreateDanvanthiriCoreTaskEvents < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_task_events do |t|
      t.string :name
      t.datetime :start_datetime
      t.integer :task_event_type, default: 0
      t.text :description
      t.belongs_to :doctor, index: true

      t.timestamps null: false
    end
  end
end
