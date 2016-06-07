module DanvanthiriCore
  class DonorSubCategory < ActiveRecord::Base
    belongs_to :donor_category
    has_many :donors, dependent: :destroy, foreign_key: "donor_sub_category_id"
    has_many :donor_requets, dependent: :destroy, foreign_key: "donor_sub_category_id"

    validates :name, presence: true
  end
end
