class AddLocationToDanvanthiriCoreAppointments < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_appointments, :working_location_id, :integer
  end
end
