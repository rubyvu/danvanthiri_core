module DanvanthiriCore
  class Membership < ActiveRecord::Base
    belongs_to :owner, polymorphic: true
  end
end
