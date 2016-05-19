module DanvanthiriCore
  class Membership < ActiveRecord::Base
    belongs_to :doctoc, polymorphic: true
  end
end
