class AddBlacklistToPatients < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_patients, :blacklist, :boolean, default: false
    add_column :danvanthiri_core_patients, :deactive_time, :datetime
    add_column :danvanthiri_core_patients, :phone_verified, :boolean, default: false
  end
end
