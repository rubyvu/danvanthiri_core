module DanvanthiriCore
  class Pharmacy < ActiveRecord::Base
    has_and_belongs_to_many :pharmacy_categories, foreign_key: "danvanthiri_core_pharmacy_id"
    validates :name, presence: true, uniqueness: true
  end
end
