module DanvanthiriCore
  module CustomValidatin
    extend ActiveSupport::Concern

    included do
      validate :integer
    end

    def special_chars
      self.class.columns.each do |column|
        value = self.send(column.name)
        if !value.blank? && column.type.to_s=="integer" && value > 2147483647
          errors.add column.name.to_sym, "integer value out of range"
        end
      end
    end
  end
end
