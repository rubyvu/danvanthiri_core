class RemoveBannerFromDanvanthiriCoreAmbulanceServices < ActiveRecord::Migration
  def change
    remove_column :danvanthiri_core_ambulance_services, :banner
  end
end
