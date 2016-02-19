module DhanvantriCore
  class Branch < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: :slugged
    
    belongs_to :category
    has_many :services, dependent: :destroy
    has_many :doctors, through: :services

    accepts_nested_attributes_for :services, allow_destroy: true

    validates :name, presence: true
  end
end
