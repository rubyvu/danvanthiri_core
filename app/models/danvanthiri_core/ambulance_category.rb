module DanvanthiriCore
  class AmbulanceCategory < ActiveRecord::Base
    has_many :ambulance_services_categories, foreign_key: "ambulance_category_id", dependent: :destroy
    has_many :ambulance_services, through: :ambulance_services_categories
    mount_uploader :icon, ImageUploader

    validates :name, presence: true
    validates :name, uniqueness: true
  end
end
