module DanvanthiriCore
  class WorkingLocation < ActiveRecord::Base
    belongs_to :doctor
    def address
      [addr_street, addr_area, addr_city, addr_state].reject{|x| x.blank?}.join(', ')
    end
  end
end
