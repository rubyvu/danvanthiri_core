module DanvanthiriCore
  class AmbulanceService < ActiveRecord::Base
    include CustomValidation
    mount_uploader :logo, ImageUploader
    mount_uploader :banner, ImageUploader

    has_many :likes, as: :likeable, dependent: :destroy
    has_many :ratings, as: :rateable, dependent: :destroy
    has_many :ambulance_services_categories, foreign_key: "ambulance_service_id", dependent: :destroy
    has_many :ambulance_categories, through: :ambulance_services_categories

    validates :name, :area, :logo, :ambulance_categories, presence: true

    # Client request display just one message, with content "Mobile number must be numbers of length 10 characters"
    validates :mobile, length: {is: 10, message: "Mobile number must be numbers of length 10 characters"}
    validates :mobile, numericality: {is: true, message: "Mobile number must be numbers of length 10 characters"}
    validates :year_of_establishment, numericality: {less_than_or_equal_to: Time.now.year}

    def update_rating!
      update_column :rate, ratings.average(:rate)
    end
  end
end
