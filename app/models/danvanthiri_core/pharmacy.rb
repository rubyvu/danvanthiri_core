module DanvanthiriCore
  class Pharmacy < ActiveRecord::Base
    validates :name, presence: true, uniqueness: true
  end
end
