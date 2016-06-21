class AddHospitalToDanvanthiriCoreDonorRequests < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_donor_requests, :hospital, :string
  end
end
