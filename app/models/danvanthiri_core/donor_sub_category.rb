module DanvanthiriCore
  class DonorSubCategory < ActiveRecord::Base
    belongs_to :donor_category
    has_many :donor_requests_donor_sub_categories, dependent: :destroy, foreign_key: "donor_sub_category_id"
    has_many :donor_requests, through: :donor_requests_donor_sub_categories
    has_many :donors, dependent: :destroy, foreign_key: "donor_sub_category_id"

    validates :name, presence: true
  end
end
