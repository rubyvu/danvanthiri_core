module DanvanthiriCore
  class Department < ActiveRecord::Base
    belongs_to :hospital
    validates :name, presence: true
  end
end
