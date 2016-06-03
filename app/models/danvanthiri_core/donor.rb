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

      def filter(filter={})
        result = Donor
        unless filter.blank?
          filter.each do |key, val|
            unless val.blank?
              result = result.where(key => val)
            end
          end
        end

        result
      end
    end

    def blood_donor?
      category=="Blood Donor"
    end

    def organ_donor?
      category=="Organ Donor"
    end

    validates :category, inclusion: {in: categories}
    validates :sub_category, inclusion: {in: blood_sub_categories}, if: Proc.new { |user| user.blood_donor? })
    validates :sub_category, inclusion: {in: organ_sub_categories}, if: Proc.new { |user| user.organ_donor? })
    validates :blood_group, inclusion: {in: blood_groups}, allow_blank: true
  end
end
