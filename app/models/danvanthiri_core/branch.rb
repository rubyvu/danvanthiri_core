module DanvanthiriCore
  class Branch < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: :slugged
    
    belongs_to :category
    has_many :branches_doctors, foreign_key: "branch_id"
    has_many :doctors, through: :branches_doctors

    validates :name, presence: true
  end
end
