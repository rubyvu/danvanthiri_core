module DanvanthiriCore
  class Department < ActiveRecord::Base
    belongs_to :hospital
    has_many :availables, as: :owner, dependent: :destroy
    accepts_nested_attributes_for :availables, allow_destroy: true

    validates :name, presence: true
  end
end
