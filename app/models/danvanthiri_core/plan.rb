module DanvanthiriCore
  class Plan < ActiveRecord::Base
    has_many :doctors_plans, foreign_key: "plan_id"
    has_many :doctors, through: :doctors_plans
    include CustomValidation

    validates :name, presence: true
    validates :unit_price, presence: true

    mount_uploader :image, ImageUploader

    scope :fixed_price, -> {where fixed_price: true}

    def price_by_locations_count(count)
      return fixed_price==true ? unit_price : unit_price*count
    end
  end
end
