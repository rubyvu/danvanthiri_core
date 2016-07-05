module DanvanthiriCore
  class CaseHistory < ActiveRecord::Base
    belongs_to :quotation
  end
end
