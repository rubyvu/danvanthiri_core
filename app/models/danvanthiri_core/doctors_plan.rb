module DanvanthiriCore
  class DoctorsPlan < ActiveRecord::Base
    enum status:  [:pending, :active, :expired]
    belongs_to :plan
    belongs_to :doctor
  end
end