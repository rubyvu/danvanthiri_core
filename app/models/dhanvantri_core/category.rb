module DhanvantriCore
  class Category < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: :slugged

    has_many :branches, dependent: :destroy

    accepts_nested_attributes_for :branches, allow_destroy: true

    validates :name, presence: true, uniqueness: true
  end
end
