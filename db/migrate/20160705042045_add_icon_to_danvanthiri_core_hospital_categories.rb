class AddIconToDanvanthiriCoreHospitalCategories < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_hospital_categories, :icon, :string
  end
end
