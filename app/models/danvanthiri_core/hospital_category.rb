module DanvanthiriCore
  class HospitalCategory < ActiveRecord::Base
    validates :name, presence: true
    validates :name, uniqueness: true
  end
end
