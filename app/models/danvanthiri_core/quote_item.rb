module DanvanthiriCore
  class QuoteItem < ActiveRecord::Base
    belongs_to :quotation

    validates :name, presence: true
    validates :price, presence: true, on: :update
    include CustomValidation
  end
end
