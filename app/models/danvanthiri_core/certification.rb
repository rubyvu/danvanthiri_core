module DanvanthiriCore
  class Certification < ActiveRecord::Base
    belongs_to :owner, polymorphic: true
    validates :name, presence: true
  end
end
