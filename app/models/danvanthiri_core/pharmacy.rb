module DanvanthiriCore
  class Pharmacy < ActiveRecord::Base
    has_many :pharmacy_category_pharmacies, foreign_key: "pharmacy_id"
    has_many :pharmacy_categories, through: :pharmacy_category_pharmacies
    validates :name, presence: true, uniqueness: true
  end
end
