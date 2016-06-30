module DanvanthiriCore
  class HospitalCategory < ActiveRecord::Base
    validates :name, presence: true
    validates :name, uniqueness: true
    has_many :hospitals_hospital_categories, foreign_key: "hospital_category_id", dependent: :destroy
    has_many :hospitals, through: :hospitals_hospital_categories
  end
end
