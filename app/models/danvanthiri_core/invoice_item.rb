module DanvanthiriCore
  class InvoiceItem < ActiveRecord::Base
    belongs_to :invoice
    belongs_to :plan
  end
end
