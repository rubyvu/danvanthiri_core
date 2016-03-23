class AddEndtimeToDanvanthiriCoreAppointments < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_appointments, :endtime, :datetime
  end
end
