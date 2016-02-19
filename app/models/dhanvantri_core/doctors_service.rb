module DhanvantriCore
  class DoctorsService < ActiveRecord::Base
    belongs_to :doctor
    belongs_to :service
  end
end
