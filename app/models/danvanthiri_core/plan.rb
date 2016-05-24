module DanvanthiriCore
  class Plan < ActiveRecord::Base
    has_many :doctors_plans, foreign_key: "plan_id"
    has_many :doctors, through: :doctors_plans
    include CustomValidation

    validates :name, presence: true
    validates :unit_price, presence: true
    
    mount_uploader :image, ImageUploader
  end
end
