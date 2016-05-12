module DanvanthiriCore
  class AmbulanceCategory < ActiveRecord::Base
    has_many :ambulance_services_categories, foreign_key: "ambulance_category_id"
    has_many :ambulance_services, through: :ambulance_services_categories
  end
end