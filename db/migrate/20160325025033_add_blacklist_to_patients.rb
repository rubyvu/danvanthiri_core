class AddBlacklistToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :blacklist, :boolean, default: false
    add_column :patients, :deactive_time, :datetime
    add_column :patients, :phone_verified, :boolean, default: false
  end
end
