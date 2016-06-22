module DanvanthiriCore
  class MedicineOrderItem < ActiveRecord::Base
    belongs_to :medicine_order
    validates :medicine_name, :quantity, presence: true
  end
end
