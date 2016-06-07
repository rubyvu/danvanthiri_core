module DanvanthiriCore
  class DonorCategory < ActiveRecord::Base
    has_many :donor_sub_categories, dependent: :destroy, foreign_key: "donor_category_id"
    has_many :donors, dependent: :destroy, foreign_key: "donor_category_id"
    has_many :donor_requets, dependent: :destroy, foreign_key: "donor_category_id"

    validates :name, presence: true
  end
end
