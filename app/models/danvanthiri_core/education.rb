module DanvanthiriCore
  class Education < ActiveRecord::Base
    belongs_to :owner, polymorphic: true

    def format_start_date
      start_date.strftime("%B %Y") if start_date
    end

    def format_start_date
      end_date.blank? "Present" : end_date.strftime("%B %Y")
    end
    
  end
end
