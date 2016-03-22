module DanvanthiriCore
  class Available < ActiveRecord::Base
    enum week_day: [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]
    belongs_to :doctor

    def f_to_hour(number)
      arr = f.to_s.split(".")
      h = arr.first.length < 10 ? "0#{arr.first}" : arr.first
      m = arr.last.length < 2 ? "#{arr.last}0" : arr.last
      "#{h}:#{m}"
    end

    def display_time
      "#{f_to_hour(time_from)} - #{f_to_hour(time_to)}"
    end    
  end
end
