class ChangeDonorRequestsTable < ActiveRecord::Migration
  def change
    remove_column :danvanthiri_core_donor_requests, :donor_sub_category_id
    add_column :danvanthiri_core_donor_requests, :lat, :float
    add_column :danvanthiri_core_donor_requests, :lng, :float
  end
end
