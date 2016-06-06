module DanvanthiriCore
  class DonorRequest < ActiveRecord::Base
    include CustomValidation
    include DonorHelper

    belongs_to :owner, polymorphic: true
  end
end
