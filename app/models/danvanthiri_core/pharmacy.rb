module DanvanthiriCore
  class Pharmacy < ActiveRecord::Base
    has_and_belongs_to_many :pharmacy_categoies, foreign_key: "pharmacy_id"
    validates :name, presence: true, uniqueness: true
  end
end
