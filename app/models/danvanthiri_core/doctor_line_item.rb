module DanvanthiriCore
  class DoctorLineItem < ActiveRecord::Base
    belongs_to :doctor_order
    belongs_to :doctor_plan
    belongs_to :plan
  end
end
