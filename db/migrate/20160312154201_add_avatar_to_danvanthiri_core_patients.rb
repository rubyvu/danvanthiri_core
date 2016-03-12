class AddAvatarToDanvanthiriCorePatients < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_patients, :avatar, :string
  end
end
