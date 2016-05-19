module DanvanthiriCore
  class Specialization < ActiveRecord::Base
    belongs_to :owner, polymorphic: true
  end
end
