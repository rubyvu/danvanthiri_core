class AddFieldsToDanvanthiriCoreHospitals < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_hospitals, :built_year, :integer
    add_column :danvanthiri_core_hospitals, :min_fee, :integer
    add_column :danvanthiri_core_hospitals, :about, :text
  end
end
