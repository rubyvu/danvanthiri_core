module DanvanthiriCore
  class Donor < ActiveRecord::Base
    include CustomValidation
    include DonorHelper

    belongs_to :patient
    belongs_to :bmi

    has_many :donors_donor_sub_categories, dependent: :destroy, foreign_key: "donor_id"
    has_many :donor_sub_categories, through: :donors_donor_sub_categories

    has_many :likes, as: :likeable, dependent: :destroy
    has_many :ratings, as: :rateable, dependent: :destroy

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

      def match_request(request)
        filter({location: request.location, donor_category_id: request.donor_category_id})
        .joins(:donors_donor_sub_categories).where("donor_sub_category_id in(?)", request.donor_sub_categories.map(&:id))
      end
    end


    def bmi_hash
      {id: bmi_id, value: bmi_value}
    end

    def bmi_value
      bmi.value if bmi
    end

    def update_rating!
      update_column :rate, ratings.average(:rate)
    end
  end
end
