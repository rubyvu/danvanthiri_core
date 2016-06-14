module DanvanthiriCore
  class QuoteItem < ActiveRecord::Base
    belongs_to :quotation

    validates :medicine_name, :quantity, presence: true
    include CustomValidation
  end
end
