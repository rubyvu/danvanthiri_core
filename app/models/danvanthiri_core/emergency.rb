module DanvanthiriCore
  class Emergency < ActiveRecord::Base
    enum status: [:pending, :accepted, :finished]
    belongs_to :patient
  end
end
