module DanvanthiriCore
  class Invoice < ActiveRecord::Base
    before_save :set_total_from_items

    enum status: [:pending, :completed, :failed]

    has_many :invoice_items, dependent: :destroy

    validates :email, uniqueness: true
    validates :invoice_items, length: { :minimum => 1 }

    accepts_nested_attributes_for :invoice_items, allow_destroy: true

    def mark_complete
      self.completed!
      touch :completed_at
    end

    def mark_fail
      self.failed!
    end



    def set_total_from_items
      invoice_items.each do |item|
        if item.plan.fixed_price
          self.total += item.plan.unit_price
        else
          self.total += item.plan.unit_price * item.quantity
        end
      end
    end


  end
end
