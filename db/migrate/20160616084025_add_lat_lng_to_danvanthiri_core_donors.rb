class AddLatLngToDanvanthiriCoreDonors < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_donors, :lat, :float
    add_column :danvanthiri_core_donors, :lng, :float
  end
end
