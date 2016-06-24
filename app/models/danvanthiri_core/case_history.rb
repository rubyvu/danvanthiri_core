module DanvanthiriCore
  class CaseHistory < ActiveRecord::Base
    belongs_to :quotation

    validates :contain, presence: true
  end
end
