module DanvanthiriCore
  class DonorsDonorSubCategory < ActiveRecord::Base
    belongs_to :donor_sub_category
    belongs_to :donor
  end
end
