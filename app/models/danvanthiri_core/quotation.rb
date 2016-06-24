module DanvanthiriCore
  class Quotation < ActiveRecord::Base
    enum status: [:pending, :responded]
    belongs_to :owner, polymorphic: true
    belongs_to :quoteable, polymorphic: true
    has_many :quote_items, dependent: :destroy, foreign_key: "quotation_id"
    has_many :treatments, dependent: :destroy, foreign_key: "quotation_id"
    has_one :case_history, dependent: :destroy, foreign_key: "quotation_id"

    has_many :notifications, as: :target

    accepts_nested_attributes_for :quote_items, allow_destroy: true
    accepts_nested_attributes_for :treatments, allow_destroy: true
    accepts_nested_attributes_for :case_history, allow_destroy: true

    def pharmacy_quote?
      self.quoteable_type.include?("Pharmacy")
    end

    def hospital_quote?
      self.quoteable_type.include?("Hospital")
    end

    validates :quote_items, presence: true, if: :pharmacy_quote?
    validates :treatments, presence: true, if: :hospital_quote?

    mount_uploader :photo, ImageUploader

    def update_price!
      if pharmacy_quote?
        update_column :total_price, quote_items.sum(:price)
      elsif hospital_quote?
        update_column :total_price, treatments.sum(:price)
      end
    end
  end
end
