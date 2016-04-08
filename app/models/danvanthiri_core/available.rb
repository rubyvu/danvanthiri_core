module DanvanthiriCore
  class Available < ActiveRecord::Base
    enum week_day: [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]
    belongs_to :doctor
    belongs_to :working_location
    validates :time_from, :time_to, :week_day, presence: true

    attr_accessor :from_hour, :from_min, :to_hour, :to_min

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
      "#{display_time_from} - #{display_time_to}"
    end 

    def display_time_from
      f_to_hour(time_from)
    end

    def display_time_to
      f_to_hour(time_to)
    end

    before_validation :set_time

    def set_time
      self.time_from = "#{self.from_hour}.#{self.from_min}" if self.from_hour && self.from_min
      self.time_to = "#{self.from_hour}.#{self.from_min}" if self.to_hour && self.to_min
      self.time_from = self.time_from.gsub(":",".") unless self.time_from.blank?
      self.time_to = self.time_to.gsub(":",".") unless self.time_to.blank?
    end
  end
end
