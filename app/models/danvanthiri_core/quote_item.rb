module DanvanthiriCore
  class QuoteItem < ActiveRecord::Base
    belongs_to :quotation

    validates :medicine_name, :quantity, presence: true
    validates :price, on: :update
    include CustomValidation
  end
end
