module DanvanthiriCore
  class Review < ActiveRecord::Base
  	belongs_to :patients
  	belongs_to :doctors

  	validates :doctor_id, :rate, :content, presence: true
	  validates :rate, inclusion: { in: 1..5 }, allow_blank: true
	  after_save :cache_rating

	  def cache_rating
	    doctor.update_rating!
	  end 
  end
end
