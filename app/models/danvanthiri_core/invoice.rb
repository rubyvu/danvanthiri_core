module DanvanthiriCore
  class Invoice < ActiveRecord::Base
    has_many :invoice_items, dependent: :destroy
    accepts_nested_attributes_for :invoice_items, allow_destroy: true
    validates :email, uniqueness: true
  end
end
