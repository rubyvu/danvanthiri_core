module DanvanthiriCore
  class PharmacyCategory < ActiveRecord::Base
    has_many :pharmacy_category_pharmacies, foreign_key: "pharmacy_category_id"
    has_many :pharmacies, through: :pharmacy_category_pharmacies
    validates :name, presence: true, uniqueness: true

    mount_uploader :icon, ImageUploader
  end
end
