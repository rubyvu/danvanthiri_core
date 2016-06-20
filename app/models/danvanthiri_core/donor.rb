module DanvanthiriCore
  class Donor < ActiveRecord::Base
    include CustomValidation
    include DonorHelper

    belongs_to :patient
    belongs_to :bmi
    belongs_to :donor_category
    has_many :donors_donor_sub_categories, dependent: :destroy, foreign_key: "donor_id"
    has_many :donor_sub_categories, through: :donors_donor_sub_categories

    validates :donor_sub_categories, presence: true


    class << self
      def filter(filter={})
        result = where("1=1")
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


    def bmi_hash
      {id: bmi_id, value: bmi_value}
    end

    def bmi_value
      bmi.value if bmi
    end

  end
end
