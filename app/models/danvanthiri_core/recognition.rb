module DanvanthiriCore
  class Recognition < ActiveRecord::Base
    belongs_to :owner, polymorphic: true
    validates :name, presence: true
  end
end
