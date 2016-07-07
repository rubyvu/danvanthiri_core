module DanvanthiriCore
  class QuoteItem < ActiveRecord::Base
    belongs_to :quotation

    validates :name, presence: true
    validates :price, presence: true, on: :update
    validates :price, numericality: { only_integer: true }, allow_blank: true
    include CustomValidation
  end
end
