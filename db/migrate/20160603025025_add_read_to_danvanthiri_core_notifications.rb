class AddReadToDanvanthiriCoreNotifications < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_notifications, :read, :boolean, default: false
  end
end
