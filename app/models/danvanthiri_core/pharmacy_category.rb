module DanvanthiriCore
  class PharmacyCategory < ActiveRecord::Base
    validates :name, presence: true, uniqueness: true
    belongs_to :patient
  end
end
