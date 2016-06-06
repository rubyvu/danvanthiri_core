module DanvanthiriCore
  module DonorHelper
    extend ActiveSupport::Concern

    included do
      belongs_to :donor_category
      belongs_to :donor_sub_category

      validates :donor_category_id, :donor_sub_category_id, presence: true
      validates :blood_group, inclusion: {in: (0..7).to_a}, allow_blank: true
    end

    module ClassMethods
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

    end

    module InstanceMethods
      def category_hash
        {id: donor_category_id, name: category_name}
      end

      def category_name
        donor_category.name if donor_category
      end

      def sub_category_hash
        {id: donor_sub_category_id, name: sub_category_name}
      end

      def sub_category_name
        donor_sub_category.name if sub_category
      end

      def blood_group_hash
        return blood_group.blank? ? {} : {id: blood_group, name: Donor.blood_groups[blood_group]}
      end

      def blood_group_name
        blood_group_hash[:name]
      end
    end

    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end
