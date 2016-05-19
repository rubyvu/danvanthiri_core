module DanvanthiriCore
  class Certification < ActiveRecord::Base
    belongs_to :owner, polymorphic: true
  end
end
