module DanvanthiriCore
  class Appointment < ActiveRecord::Base
    enum status: [:pending, :accepted, :finished, :expired, :rescheduled, :cancelled_by_patient, :cancelled_by_doctor, :rejected]
    belongs_to :patient
    belongs_to :doctor
    belongs_to :working_location

    validates :booktime, :doctor_id, :working_location, presence: true

    attr_accessor :date_str, :time_str

    scope :pending, -> {where status: 0}
    scope :accepted, -> {where status: 1}
    scope :finished, -> {where status: 2}
    scope :cancelled, -> {where status: 3}

    scope :past, -> {where("booktime < ?", DateTime.now)}
    scope :upcomming, -> {where("booktime > ?", DateTime.now)}

    class << self
      def filter(term, filter={})
        result = Appointment
        result = Appointment.all if term.blank? && filter.blank?
        unless filter.blank?
          filter.each do |key, val|
            unless val.blank?
              if key == :book_date
                date = Date.parse(val)
                result = result.where(booktime: date.beginning_of_day..date.end_of_day)
              else
                result = result.where(key => val)
              end
            end
          end
        end

        unless term.blank?
          result = result.joins(:patient, :doctor).where("
            CONCAT(LOWER(danvanthiri_core_doctors.first_name), ' ', LOWER(danvanthiri_core_doctors.last_name)) like ?
            or CONCAT(LOWER(danvanthiri_core_patients.first_name), ' ', LOWER(danvanthiri_core_patients.last_name)) like ?",
            "%#{term.downcase}%", "%#{term.downcase}%")
        end

        result
      end
    end


    before_validation :set_booking_time
    after_create :set_status

    def set_booking_time
      if self.date_str && self.time_str && self.doctor_id && self.working_location_id
        begin
          start_date = DateTime.parse "#{date_str} #{time_str}"

          doctor = Doctor.find self.doctor_id
          arr = self.time_str.split(":")
          avail = doctor.availables.where(start_hour: arr.first.to_i, start_min: arr.last.to_i, week_day: start_date.wday, owner: self.working_location).first

          end_date = DateTime.parse "#{date_str} #{avail.display_end_time}" if avail

          self.booktime = start_date - 5.5.hours
          self.endtime = end_date - 5.5.hours if end_date
        rescue Exception => e
          puts e.message
        end
      end
    end

    def set_status
      accepted! if doctor.auto_accept_booking?
    end

    def patient_name
      patient.name if patient
    end

    def doctor_name
      doctor.name if doctor
    end

    def display_booktime
      booktime.strftime("%d, %b %Y %H:%M") if booktime
    end

    def display_date
      booktime.strftime("%Y-%m-%d")
    end

    def display_time
      booktime.strftime("%H:%M")
    end
  end
end
