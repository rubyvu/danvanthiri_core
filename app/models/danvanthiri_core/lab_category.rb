module DanvanthiriCore
  class LabCategory < ActiveRecord::Base
    has_many :labs, foreign_key: "lab_category_id", dependent: :destroy
    validates :name, presence: true
    validates :name, uniqueness: true
    mount_uploader :logo, ImageUploader
  end
end
