class AddBookableToDanvanthiriCoreAppointments < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_appointments, :bookable_id, :integer
    add_column :danvanthiri_core_appointments, :bookable_type, :string
  end
end
