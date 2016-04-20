module DanvanthiriCore
  class Department < ActiveRecord::Base
    belongs_to :hospital
    has_many :availables, as: :owner, dependent: :destroy
    
    validates :name, presence: true
  end
end
