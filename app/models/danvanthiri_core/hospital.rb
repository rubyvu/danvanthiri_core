module DanvanthiriCore
  class Hospital < ActiveRecord::Base

    scope :active, -> {where active: true}
    scope :unactive, -> {where active: false}

    def active!
      update_column :active, true
    end

    def de_active!
      update_column :active, false
    end

    def address
      [addr_street, addr_area, addr_city, addr_state].reject{|x| x.blank?}.join(', ')
    end

  end
end
