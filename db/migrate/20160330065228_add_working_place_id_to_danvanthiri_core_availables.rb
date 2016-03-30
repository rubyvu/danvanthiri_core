class AddWorkingPlaceIdToDanvanthiriCoreAvailables < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_availables, :working_location_id, :integer
  end
end
