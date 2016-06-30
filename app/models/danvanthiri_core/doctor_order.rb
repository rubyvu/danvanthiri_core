module DanvanthiriCore
  class DoctorOrder < ActiveRecord::Base
    has_many :doctor_line_items, dependent: :destroy
  end
end
