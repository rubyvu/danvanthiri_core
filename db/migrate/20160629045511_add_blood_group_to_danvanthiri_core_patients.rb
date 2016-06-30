class AddBloodGroupToDanvanthiriCorePatients < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_patients, :blood_group, :integer
  end
end
