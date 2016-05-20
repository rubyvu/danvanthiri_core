module DanvanthiriCore
  class Registration < ActiveRecord::Base
    belongs_to :owner, polymorphic: true
    validates :name, presence: true
  end
end
