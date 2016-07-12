module DanvanthiriCore
  class Quotation < ActiveRecord::Base
    enum status: [:pending, :responded]
    belongs_to :owner, polymorphic: true
    belongs_to :quoteable, polymorphic: true
    belongs_to :quote_thread
    has_many :quote_items, dependent: :destroy, foreign_key: "quotation_id"
    has_one :case_history, dependent: :destroy, foreign_key: "quotation_id"

    has_many :notifications, as: :target, dependent: :destroy

    accepts_nested_attributes_for :quote_items, allow_destroy: true
    accepts_nested_attributes_for :case_history, allow_destroy: true

    class << self
      def for_hospital
        where(quoteable_type: "DanvanthiriCore::Hospital")
      end

      def for_pharmacy
        where(quoteable_type: "DanvanthiriCore::Pharmacy")
      end

      def for_lab
        where(quoteable_type: "DanvanthiriCore::Lab")
      end
    end

    def pharmacy_quote?
      self.quoteable_type.include?("Pharmacy")
    end

    def hospital_quote?
      self.quoteable_type.include?("Hospital")
    end

    def lab_quote?
      self.quoteable_type.include?("Lab")
    end

    validate :check_items

    mount_uploader :photo, ImageUploader

    def update_price!
      update_column :total_price, quote_items.sum(:price)
    end

    private
    def check_items
      if self.quote_items.blank? && self.photo.blank?
        errors.add :quote_items, "can't  be blank."
      end
    end
  end
end
