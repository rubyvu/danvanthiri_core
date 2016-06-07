module DanvanthiriCore
  class PharmacyCategory < ActiveRecord::Base
    validates :name, presence: true, uniqueness: true
    
    mount_uploader :icon, ImageUploader
  end
end
