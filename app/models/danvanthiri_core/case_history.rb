module DanvanthiriCore
  class CaseHistory < ActiveRecord::Base
    belongs_to :quotation

    validates :content, presence: true
  end
end
