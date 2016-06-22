module DanvanthiriCore
  class QuoteItem < ActiveRecord::Base
    belongs_to :quotation

    validates :medicine_name, :quantity, presence: true
    validates :price, presence: true, on: :update
    include CustomValidation
  end
end
