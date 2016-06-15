module DanvanthiriCore
  class AmbulanceService < ActiveRecord::Base
    include CustomValidation
    mount_uploader :banner, ImageUploader
    mount_uploader :logo, ImageUploader

    has_many :likes, as: :likeable, dependent: :destroy
    has_many :ratings, as: :rateable, dependent: :destroy
    has_many :ambulance_services_categories, foreign_key: "ambulance_service_id", dependent: :destroy
    has_many :ambulance_categories, through: :ambulance_services_categories

    validates :name, :area, presence: true
    validates :mobile, presence: true
    validates :mobile, length: { is: 10 }, allow_blank: true

    def update_rating!
      update_column :rate, ratings.average(:rate)
    end
  end
end
