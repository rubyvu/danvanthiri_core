class AddAddrToDanvanthiriCoreWorkingLocations < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_working_locations, :address, :string
  end
end
