module DanvanthiriCore
  class Pcplan < ActiveRecord::Base
    has_many :patient_coordinators_pcplans, foreign_key: "pcplan_id"
    has_many :patient_coordinators, through: :patient_coordinators_pcplans
    include CustomValidation

    validates :name, presence: true
    validates :unit_price, presence: true
    mount_uploader :image, ImageUploader

    def price_by_locations_count(count)
      return fixed_price==true ? unit_price : unit_price*count
    end
  end
end
