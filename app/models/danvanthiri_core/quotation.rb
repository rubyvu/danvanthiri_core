module DanvanthiriCore
  class Quotation < ActiveRecord::Base
    enum status: [:pending, :responded]
    belongs_to :owner, polymorphic: true
    belongs_to :quoteable, polymorphic: true
    has_many :quote_items, dependent: :destroy, foreign_key: "quotation_id"
    has_many :notifications, as: :target

    accepts_nested_attributes_for :quote_items, allow_destroy: true
    validates :quote_items, presence: true

    mount_uploader :photo, ImageUploader

    def update_price!
      update_column :total_price, quote_items.sum(:price)
    end
  end
end
