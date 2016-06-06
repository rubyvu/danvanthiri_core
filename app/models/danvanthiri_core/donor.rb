module DanvanthiriCore
  class Donor < ActiveRecord::Base
    include CustomValidation
    include DonorHelper
    belongs_to :patient
    belongs_to :bmi

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
      {id: bmi_id, value: bmi_value}
    end

    def bmi_value
      bmi.value if bmi
    end

  end
end
