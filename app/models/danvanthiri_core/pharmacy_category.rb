module DanvanthiriCore
  class PharmacyCategory < ActiveRecord::Base
    has_and_belongs_to_many :pharmacies, foreign_key: "pharmacy_category_id"
    validates :name, presence: true, uniqueness: true

    mount_uploader :icon, ImageUploader
  end
end
