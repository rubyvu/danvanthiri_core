module DanvanthiriCore
  class Bmi < ActiveRecord::Base
    has_many :donors, dependent: :destroy, foreign_key: "bmi_id"

    validates :value, presence: true
  end
end
