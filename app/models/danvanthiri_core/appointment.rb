module DanvanthiriCore
  class Appointment < ActiveRecord::Base
    enum status: [:pending, :accepted, :finished, :cancelled]
    belongs_to :patient
    belongs_to :doctor

    validates :booktime, presence: true

    attr_accessor :date_str, :time_str

    scope :pending, -> {where status: 0}

    before_validation :set_booking_time

    def as_json(options = {})
      options = options.merge(except: [:created_at, :updated_at])
      super(options)
    end

    def details
      as_json(include: {doctor: {only: [:id, :name]}, patient: {only: [:id, :name]} })
    end 
  
    def set_booking_time
      if self.date_str && self.time_str
        self.booktime = DateTime.parse "#{date_str} #{time_str}"
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
