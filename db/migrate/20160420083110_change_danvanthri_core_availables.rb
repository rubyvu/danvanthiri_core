class ChangeDanvanthriCoreAvailables < ActiveRecord::Migration
  def change
    rename_column :danvanthiri_core_availables, :working_location_id, :owner_id
    add_column :danvanthiri_core_availables,:owner_type, :string
    DanvanthiriCore::Available.update_all owner_type: 'DanvanthiriCore::WorkingLocation'
  end
end
