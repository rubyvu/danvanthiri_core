module DanvanthiriCore
  class Available < ActiveRecord::Base
    enum week_day: [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]
    belongs_to :doctor
    validates :time_from, :time_to, :week_day, presence: true

    def f_to_hour(number, display_ampm=false)
     
      h = number.to_i
      if display_ampm
        ampm = "pm"
        if h < 12
          ampm = "am"
        elsif h > 12
          h = h-12
        end
      end

      h = h < 10 ? "0#{h}" : h

      arr = number.to_s.split(".")
      m = arr.last.length < 2 ? "#{arr.last}0" : arr.last
      str = "#{h}:#{m}"
      str += " #{ampm}" if display_ampm
      str
    end

    def display_time
      "#{f_to_hour(time_from)} - #{f_to_hour(time_to)}"
    end 
  end
end
