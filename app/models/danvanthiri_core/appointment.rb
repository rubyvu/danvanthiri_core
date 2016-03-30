module DanvanthiriCore
  class Appointment < ActiveRecord::Base
    enum status: [:pending, :accepted, :finished, :cancelled]
    belongs_to :patient
    belongs_to :doctor
    belongs_to :working_location

    validates :booktime, presence: true

    attr_accessor :date_str, :time_str

    scope :pending, -> {where status: 0}
    scope :accepted, -> {where status: 1}
    scope :finished, -> {where status: 2}
    scope :cancelled, -> {where status: 3}

    scope :past, -> {where("booktime < ?", DateTime.now)}
    scope :upcomming, -> {where("booktime > ?", DateTime.now)}

    before_validation :set_booking_time
  
    def set_booking_time
      if self.date_str && self.time_str && self.doctor_id && self.location_id
        begin
          start_date = DateTime.parse "#{date_str} #{time_str}"
          
          doctor = Doctor.find self.doctor_id
          time = self.time_str.gsub(":", ".").to_f
          avail = doctor.availables.where(time_from: time, week_day: start_date.wday, location_id: self.location_id).first

          end_date = DateTime.parse "#{date_str} #{avail.display_time_to}"

          self.booktime = start_date - 5.5.hours
          self.endtime = end_date - 5.5.hours
        rescue Exception => e
          puts e.message
        end
      end
    end

    def patient_name
      patient.name if patient
    end

    def doctor_name
      doctor.name if doctor
    end

    def display_booktime
      booktime.strftime("%d, %b %Y %I:%M %p") if booktime
    end

    def display_date
      booktime.strftime("%Y-%m-%d")
    end

    def display_time
      booktime.strftime("%H:%M")
    end
  end
end