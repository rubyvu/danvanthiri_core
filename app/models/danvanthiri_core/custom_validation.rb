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
          begin
            val = Integer(value)
            errors.add column.name.to_sym, "integer value out of range" if val > 2147483647
          rescue
            errors.add column.name.to_sym, "must be integer"
          end
        end
      end
    end
  end
end
