module DanvanthiriCore
  class HospitalsHospitalCategory < ActiveRecord::Base
    belongs_to :hospital
    belongs_to :hospital_category
  end
end
