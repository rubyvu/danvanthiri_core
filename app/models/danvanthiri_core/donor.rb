module DanvanthiriCore
  class Donor < ActiveRecord::Base
    belongs_to :patient
    validates :category, :sub_category, presence: true
    class << self
      def categories
        ["Blood Donor", "Organ Donor"]
      end

      def blood_sub_categories
        ["Platellets", "Blood Cells"]
      end

      def organ_sub_categories
        ["Eye", "Heart", "Kidney", "Liver", "Whole Body"]
      end

      def blood_groups
        ["AB-", "AB+", "B-", "B+", "A-", "A+", "O-", "O+"]
      end
    end
  end
end
