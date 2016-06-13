module DanvanthiriCore
  class AmbulanceService < ActiveRecord::Base
    include CustomValidation
    mount_uploader :banner, ImageUploader

    has_many :ambulance_services_categories, foreign_key: "ambulance_service_id", dependent: :destroy
    has_many :ambulance_categories, through: :ambulance_services_categories

    validates :name, :area, :logo, presence: true
    validates :mobile, presence: true
    validates :mobile, length: { is: 10 }, allow_blank: true

  end
end
