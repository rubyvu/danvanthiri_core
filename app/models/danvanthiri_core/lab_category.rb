module DanvanthiriCore
  class LabCategory < ActiveRecord::Base
    validates :name, presence: true
    validates :name, uniqueness: true
    mount_uploader :logo, ImageUploader
  end
end
