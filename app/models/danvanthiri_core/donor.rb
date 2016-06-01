module DanvanthiriCore
  class Donor < ActiveRecord::Base
    attr_accessor :blood_sub_category, :organ_sub_category
    belongs_to :patient
    validates :category, :sub_category, presence: true
    class << self
      def categories
        ["Blood Donor", "Organ Donor"]
      end

      def blood_sub_categoies
        ["Platellets", "Blood Cells"]
      end

      def organ_sub_categories
        ["Eye", "Heart", "Kidney", "Liver", "Whole Body"]
      end

      def blood_groups
        ["AB-", "AB+", "B-", "B+", "A-", "A+", "O-", "O+"]
      end
    end

    before_validation :set_sub_category
    def set_sub_category
      self.sub_category = self.blood_sub_category unless self.blood_sub_category.blank?
      self.sub_category = self.organ_sub_category unless self.organ_sub_category.blank?
    end
  end
end
