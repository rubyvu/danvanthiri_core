module DanvanthiriCore
  class BranchesDoctors < ActiveRecord::Base
    belongs_to :doctor
    belongs_to :branch
  end
end