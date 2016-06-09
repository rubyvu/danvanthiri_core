module DanvanthiriCore
  class Rating < ActiveRecord::Base
    belongs_to :owner, polymorphic: true
  	belongs_to :rateable, polymorphic: true

  	validates :owner_id, :rateable_id, :rate, :review, presence: true
	  validates :rate, inclusion: { in: 1..5 }, allow_blank: true

	  after_save :cache_rating
    include CustomValidation

	  def cache_rating
	    rateable.update_rating!
	  end
  end
end
