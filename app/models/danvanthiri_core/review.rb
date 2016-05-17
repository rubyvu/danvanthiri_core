module DanvanthiriCore
  class Review < ActiveRecord::Base
  	belongs_to :patient
  	belongs_to :doctor

  	validates :doctor_id, :rate, :content, presence: true
	  validates :rate, inclusion: { in: 1..5 }, allow_blank: true
	  after_save :cache_rating
    include CustomValidation
    
	  def cache_rating
	    doctor.update_rating!
	  end
  end
end
