module DanvanthiriCore
  class Available < ActiveRecord::Base
    enum week_day: [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]
    belongs_to :doctor
    belongs_to :working_location
    validates :week_day, presence: true
    validate :check_time

    attr_accessor :start_time, :end_time

    scope :morning, -> {where "start_hour < 12"}
    scope :afternoon, -> {where "start_hour >= 12 and start_hour < 17"}
    scope :everning, -> {where "start_hour >= 17"}

    def add_zero(number)
      str = number && number < 10 ? "0#{number}" : number
      str
    end

    def start_hour_str
      add_zero(start_hour)
    end

    def start_min_str
      add_zero(start_min)
    end

    def end_hour_str
      add_zero(end_hour)
    end

    def end_min_str
      add_zero(end_min)
    end

    def display_time
      "#{display_start_time} - #{display_end_time}"
    end 

    def display_start_time
      "#{start_hour_str}:#{start_min_str}"
    end

    def display_end_time
      "#{end_hour_str}:#{end_min_str}"
    end

    before_validation :set_time

    def set_time
      unless self.start_time.blank?
        arr = self.start_time.split(":")
        self.start_hour = arr.first
        self.end_min = arr.last
      end

      unless self.end_time.blank?
        arr = self.end_time.split(":")
        self.end_hour = arr.first
        self.end_min = arr.last
      end
    end

    def check_time
      errors.add :base, "Invalid start time" if start_hour.blank? || start_min.blank?
      errors.add :base, "Invalid end time" if end_hour.blank? || end_min.blank?
    end
  end
end
