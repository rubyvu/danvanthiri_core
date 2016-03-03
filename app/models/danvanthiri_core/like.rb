module DanvanthiriCore
  class Like < ActiveRecord::Base
    belongs_to :patient
    belongs_to :likeable, polymorphic: true
  end
end
