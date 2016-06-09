module DanvanthiriCore
  class PharmacyCategoryPharmacy < ActiveRecord::Base
    belongs_to :pharmacy_category
    belongs_to :pharmacy
  end
end
