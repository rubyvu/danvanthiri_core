module DanvanthiriCore
  class DonorRequestsDonorSubCategory < ActiveRecord::Base
    belongs_to :donor_request
    belongs_to :donor_sub_category
  end
end
