class AddOwnerTypeToWorkingLocations < ActiveRecord::Migration
  def change
    rename_column :danvanthiri_core_working_locations, :doctor_id, :owner_id
    add_column :danvanthiri_core_working_locations, :owner_type, :string
    DanvanthiriCore::WorkingLocation.update_all owner_type: "DanvanthiriCore::Doctor"
  end
end
