module DanvanthiriCore
  class DoctorOrder < ActiveRecord::Base
    has_many :doctor_line_items, dependent: :destroy
    accepts_nested_attributes_for :doctor_line_items, allow_destroy: true
  end
end
