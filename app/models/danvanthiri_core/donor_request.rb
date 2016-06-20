module DanvanthiriCore
  class DonorRequest < ActiveRecord::Base
    include CustomValidation
    include DonorHelper

    belongs_to :owner, polymorphic: true

    has_many :donor_requests_donor_sub_categories, dependent: :destroy, foreign_key: "donor_request_id"
    has_many :donor_sub_categories, through: :donor_requests_donor_sub_categories

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
