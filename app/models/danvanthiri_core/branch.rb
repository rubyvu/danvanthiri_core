module DanvanthiriCore
  class Branch < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: :slugged
    
    belongs_to :category
    has_many :doctors, foreign_key: "branch_id"

    validates :name, presence: true
  end
end
