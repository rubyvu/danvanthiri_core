class AddConsultationFeeToDanvanthiriCoreWorkingLocations < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_working_locations, :consultation_fee, :integer
  end
end
