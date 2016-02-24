module DanvanthiriCore
  class BranchesDoctor < ActiveRecord::Base
    belongs_to :doctor
    belongs_to :branch
  end
end