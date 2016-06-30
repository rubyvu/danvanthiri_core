module DanvanthiriCore
  class InvoiceItem < ActiveRecord::Base
    belongs_to :invoice
    belongs_to :plan

    validates :price, presence: true
    validates :quantity, :numericality => { :greater_than => 0 }
    validates :plan, presence: true
    validates :invoice, presence: true
  end
end
