module DanvanthiriCore
  class DoctorsHospital < ActiveRecord::Base
    belongs_to :doctor
    belongs_to :hospital
  end
end
