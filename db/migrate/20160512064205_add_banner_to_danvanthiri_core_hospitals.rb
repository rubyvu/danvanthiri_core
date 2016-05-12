class AddBannerToDanvanthiriCoreHospitals < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_hospitals, :banner, :string
    add_column :danvanthiri_core_hospitals, :premium, :boolean
  end
end
