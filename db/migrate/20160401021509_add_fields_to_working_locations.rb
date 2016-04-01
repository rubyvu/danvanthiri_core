class AddFieldsToWorkingLocations < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_working_locations, :logo, :string
    add_column :danvanthiri_core_working_locations, :start_date, :datetime
    add_column :danvanthiri_core_working_locations, :end_date, :datetime
    add_column :danvanthiri_core_working_locations, :lat, :float
    add_column :danvanthiri_core_working_locations, :lng, :float
  end
end
