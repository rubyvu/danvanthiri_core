module DanvanthiriCore
  class Pharmacy < ActiveRecord::Base
    has_many :pharmacy_category_pharmacies, foreign_key: "pharmacy_id"
    has_many :pharmacy_categories, through: :pharmacy_category_pharmacies
    has_many :likes, as: :likeable, dependent: :destroy
    has_many :ratings, as: :rateable, dependent: :destroy

    validates :name, presence: true, uniqueness: true

    def update_rating!
      update_column :rate, ratings.average(:rate)
    end
  end
end
