module DanvanthiriCore
  class Donor < ActiveRecord::Base
    belongs_to :patient
    validates :category, :sub_category, presence: true

    class << self
      def categories
        ["Blood Donor", "Organ Donor"]
      end

      def sub_categories
        ["Platellets", "Blood Cells"]
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

      def bmis
        ["1-10", "10-20", "30 & above"]
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

    def category_hash
      return category.blank? ? {} : {id: category, name: Donor.categories[category]}
    end

    def category_name
      category_hash[:name]
    end

    def sub_category_hash
      return sub_category.blank? ? {} : {id: sub_category, name: Donor.sub_categories[sub_category]}
    end

    def sub_category_name
      sub_category_hash[:name]
    end

    def blood_group_hash
      return blood_group.blank? ? {} : {id: blood_group, name: Donor.blood_groups[blood_group]}
    end

    def blood_group_name
      blood_group_hash[:name]
    end

    def bmi_hash
      return bmi.blank? ? {} : {id: bmi, value: Donor.bmis[bmi]}
    end

    def bmi_value
      blood_group_hash[:value]
    end

    validates :category, inclusion: {in: [0,1]}
    validates :blood_group, inclusion: {in: (0..7).to_a}, allow_blank: true
  end
end
