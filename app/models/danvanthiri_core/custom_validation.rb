module DanvanthiriCore
  module CustomValidation
    extend ActiveSupport::Concern

    included do
      validate :integer_field
    end

    def integer_field
      self.class.columns.each do |column|
        value = self.send(column.name)
        if !value.blank? && column.type.to_s=="integer" && value.to_i > 2147483647
          errors.add column.name.to_sym, "integer value out of range"
        end
      end
    end
  end
end
