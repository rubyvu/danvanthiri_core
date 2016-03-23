class AddLatLngToDanvanthiriCoreDoctors < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_doctors, :lat, :float
    add_column :danvanthiri_core_doctors, :lng, :float
  end
end
