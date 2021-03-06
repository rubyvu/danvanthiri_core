module DanvanthiriCore
  class Available < ActiveRecord::Base
    #enum week_day: [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :all_day]
    belongs_to :owner, polymorphic: true
    #validates :week_day, presence: true
    validate :check_time
    include CustomValidation

    attr_accessor :start_time, :end_time

    scope :morning, -> {where "start_hour < 12"}
    scope :afternoon, -> {where "start_hour >= 12 and start_hour < 17"}
    scope :everning, -> {where "start_hour >= 17"}
    scope :sunday, -> {where sunday: true}
    scope :monday, -> {where monday: true}
    scope :tuesday, -> {where tuesday: true}
    scope :wednesday, -> {where wednesday: true}
    scope :thursday, -> {where thursday: true}
    scope :friday, -> {where friday: true}
    scope :saturday, -> {where saturday: true}

    def self.by_date(date)
      wday = date.strftime("%A").downcase
      send(wday)
    end

    def json_details
      {
        id: id,
        start_hour: start_hour, start_min: start_min, end_hour: end_hour, end_min: end_min,
        start_time: display_start_time, end_time: display_end_time,
        sunday: sunday?, monday: monday?, tuesday: tuesday?, wednesday: wednesday?, thursday: thursday?, friday: friday?,
        saturday: saturday?
      }
    end

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

    def display_time(ampm=true)
      "#{display_start_time(ampm)} - #{display_end_time(ampm)}"
    end

    def display_start_time(ampm=true)
      if h = start_hour
        if ampm
          flag = h > 11 ? " PM" : " AM"
          h = h-12 if h > 12
        end
        "#{add_zero(h)}:#{add_zero(start_min)}#{flag}"
      end
    end

    def display_end_time(ampm=true)
      if h = end_hour
        if ampm
          flag = h > 11 ? " PM" : " AM"
          h = h-12 if h > 12
        end
        "#{add_zero(h)}:#{add_zero(end_min)}#{flag}"
      end
    end

    def week_days
      arr = []
      arr << "Sunday" if sunday?
      arr << "Monday" if monday?
      arr << "Tuesday" if tuesday?
      arr << "Wednesday" if wednesday?
      arr << "Thursday" if thursday?
      arr << "Friday" if friday?
      arr << "Saturday" if saturday?
      arr.join ", "
    end

    before_validation :set_time

    def set_time
      unless self.start_time.blank?
        arr = self.start_time.split(":")
        self.start_hour = arr.first
        self.start_min = arr.last
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
