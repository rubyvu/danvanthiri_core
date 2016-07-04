module DanvanthiriCore
  class PcPlan < ActiveRecord::Base
    validates :name, presence: true
    validates :unit_price, presence: true
  end
end
