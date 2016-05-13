module DanvanthiriCore
  class Post < ActiveRecord::Base
    belongs_to :owner, polymorphic: true
    validates :title, :content, presence: true
  end
end
