module DanvanthiriCore
  class DonorRequest < ActiveRecord::Base
    include CustomValidation
    include DonorHelper

    belongs_to :owner, polymorphic: true

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
  end
end
