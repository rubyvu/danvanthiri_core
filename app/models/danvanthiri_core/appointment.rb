module DanvanthiriCore
  class Appointment < ActiveRecord::Base
    enum status: [:pending, :accepted, :finished, :cancelled]
    belongs_to :patient
    belongs_to :doctor

    validates :booktime, presence: true

    attr_accessor :date_str, :time_str

    scope :pending, -> {where status: 0}
    scope :accepted, -> {where status: 1}
    scope :finished, -> {where status: 2}
    scope :cancelled, -> {where status: 3}


    before_validation :set_booking_time

    def as_json(options = {})
      options = options.merge(except: [:created_at, :updated_at])
      super(options)
    end

    def details
      as_json(include: {doctor: {only: [:id, :name]}, patient: {only: [:id, :name]} })
    end 
  
    def set_booking_time
      if self.date_str && self.time_str && self.doctor_id
        begin
          start_date = DateTime.parse "#{date_str} #{time_str}"
          
          doctor = Doctor.find self.doctor_id
          time = self.time_str.gsub(":", ".").to_f
          avail = doctor.availables.where(time_from: time, week_day: start_date.wday).first

          end_date = DateTime.parse "#{date_str} #{avail.display_time_to}"

          self.booktime = start_date
          self.endtime = end_date
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
