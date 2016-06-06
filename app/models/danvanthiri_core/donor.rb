module DanvanthiriCore
  class Donor < ActiveRecord::Base
    include CustomValidation
    include DonorHelper
    belongs_to :patient
    validates :category, :sub_category, presence: true

    class << self
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


    def bmi_hash
      return bmi.blank? ? {} : {id: bmi, value: Donor.bmis[bmi]}
    end

    def bmi_value
      bmi_hash[:value]
    end

  end
end
