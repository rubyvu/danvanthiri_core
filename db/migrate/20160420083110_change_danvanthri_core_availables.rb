class ChangeDanvanthriCoreAvailables < ActiveRecord::Migration
  def change
    rename_column :working_location_id, :owner_id
    add_column :owner_type, :string
    Available.update_all owner_type: 'DanvanthiriCore::WorkingLocation'
  end
end
