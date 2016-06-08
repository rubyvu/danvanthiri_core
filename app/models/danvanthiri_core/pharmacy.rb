module DanvanthiriCore
  class Pharmacy < ActiveRecord::Base
    has_and_belongs_to_many :pharmacy_categories
    validates :name, presence: true, uniqueness: true
  end
end
