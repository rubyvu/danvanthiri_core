module DanvanthiriCore
  class Quotation < ActiveRecord::Base
    enum status: [:pending, :responded]
    belongs_to :owner, polymorphic: true
    belongs_to :quoteable, polymorphic: true
    belongs_to :quote_thread
    belongs_to :patient, foreign_key: "owner_id"
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

    mount_uploader :photo, ImageUploader

    def update_price!
      update_column :total_price, quote_items.sum(:price)
    end

    def self.filter(term, filter={})
      result = Quotation
      result = Quotation.all if term.blank? && filter.blank?

      unless term.blank?
        result = Quotation.joins(:patient).where("danvanthiri_core_quotations.owner_type = ?", "DanvanthiriCore::Patient")
                     .where(" LOWER(danvanthiri_core_quotations.quoteable_type) like ?
                        OR CONCAT(LOWER(danvanthiri_core_patients.first_name), ' ', LOWER(danvanthiri_core_patients.last_name)) like ?",
                            "%#{term.downcase}%", "%#{term.downcase}%")

      end
      result
    end
  end
end
