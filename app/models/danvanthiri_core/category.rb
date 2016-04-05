module DanvanthiriCore
  class Category < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: :slugged

    has_many :branches, dependent: :destroy, foreign_key: "category_id"
    has_many :doctors, foreign_key: "category_id"

    accepts_nested_attributes_for :branches, allow_destroy: true

    validates :name, presence: true, uniqueness: true
  end
end
