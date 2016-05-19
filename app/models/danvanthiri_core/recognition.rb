module DanvanthiriCore
  class Recognition < ActiveRecord::Base
    belongs_to :owner, polymorphic: true
  end
end
