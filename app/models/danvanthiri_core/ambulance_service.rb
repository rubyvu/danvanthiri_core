module DanvanthiriCore
  class AmbulanceService < ActiveRecord::Base
    has_many :ambulance_services_categories, foreign_key: "ambulance_service_id"
    has_many :ambulance_categories, through: :ambulance_services_categories

    validates :name, :area, :logo, presence: true
    validates :mobile, presence: true, length: { is: 10 }

  end
end
