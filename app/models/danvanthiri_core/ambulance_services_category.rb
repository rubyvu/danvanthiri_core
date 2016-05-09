module DanvanthiriCore
  class AmbulanceServicesCategory < ActiveRecord::Base
    belongs_to :ambulance_category
    belongs_to :ambulance_service
  end
end
