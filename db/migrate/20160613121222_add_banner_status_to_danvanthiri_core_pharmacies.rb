class AddBannerStatusToDanvanthiriCorePharmacies < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_pharmacies, :banner_status, :boolean, default: false
    add_column :danvanthiri_core_pharmacies, :banner, :string
  end
end
