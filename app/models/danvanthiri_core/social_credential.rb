module DanvanthiriCore
  class SocialCredential < ActiveRecord::Base
    belongs_to :patient
    validates :uid, presence: true, uniqueness: true
  end
end
