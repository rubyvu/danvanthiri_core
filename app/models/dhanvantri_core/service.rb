module DhanvantriCore
  class Service < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: :slugged
    
    belongs_to :branch
    has_many :doctors_services
    has_many :doctors, through: :doctors_services

    has_one :category, through: :branch

    validates :name, presence: true
  end
end
