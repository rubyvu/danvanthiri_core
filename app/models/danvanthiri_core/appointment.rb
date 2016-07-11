module DanvanthiriCore
  class Appointment < ActiveRecord::Base
    @@status_for_dept_hospital_booking = {pending: :pending, accepted: :accepted,
                                          finished: :finished, cancelled_by_doctor: :cancelled_by_doctor}

    enum status: [:pending, :accepted, :finished, :expired, :rescheduled, :cancelled_by_patient, :cancelled_by_doctor, :rejected, :cancelled_by_pc]
    enum book_type: [:doctor_booking, :department_booking, :hospital_booking, :patient_coordinator_booking, :medicine_booking, :lab_booking]
    belongs_to :patient
    belongs_to :doctor
    belongs_to :patient_coordinator
    belongs_to :working_location
    belongs_to :hospital
    belongs_to :department
    belongs_to :bookable, polymorphic: true

    has_one :medicine_order, as: :owner, dependent: :destroy

    has_many :notifications, as: :target, dependent: :destroy

    accepts_nested_attributes_for :medicine_order, allow_destroy: true

    validates :booktime, presence: true, unless: :medicine_booking?
    validates :working_location, presence: true, if: :doctor_booking?
    validates :doctor_id, presence: true, if: :doctor_booking?
    validates :hospital_id, presence: true, if: :hospital_booking?
    validates :hospital_id, presence: true, if: :department_booking?

    validates :patient_coordinator_id, presence: true, if: :patient_coordinator_booking?
    validates :status, inclusion: {in: [:pending.to_s, :accepted.to_s, :finished.to_s, :cancelled_by_doctor.to_s], message: "%{value} is not a valid status"},
              if: :dept_hospital_book_type?
    attr_accessor :date_str, :time_str

    scope :cancelled, -> {where status: [5,6]}

    scope :history, -> {where("danvanthiri_core_appointments.status = 2 or (danvanthiri_core_appointments.endtime < ? and danvanthiri_core_appointments.status=1)", DateTime.current)}
    scope :upcoming, -> {where("danvanthiri_core_appointments.status IN (0,1) AND (booktime is NULL or booktime > ?)", DateTime.current)}
    scope :past_pc, -> {where("danvanthiri_core_appointments.status = 2 AND endtime < ?", DateTime.current)} # past appointment for patient coordinator app
    scope :upcoming_pc, -> {where("danvanthiri_core_appointments.status = 1 AND booktime > ?", DateTime.current)} # upcoming appointment for patient coordinator app
    scope :pending_pc, -> {where("danvanthiri_core_appointments.status = 0 AND booktime > ?", DateTime.current)} # pending appointment for patient coordinator app

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
      if self.date_str && self.time_str && (self.doctor_id || self.patient_coordinator_id) && (self.working_location_id || !self.doctor_booking?)
        begin
          start_date = DateTime.parse "#{date_str} #{time_str}"
          wday = start_date.strftime("%A").downcase
          availables = self.working_location ? self.working_location.availables : self.doctor.availables
          arr = self.time_str.split(":")
          avail = availables.where(start_hour: arr.first.to_i, start_min: arr.last.to_i, wday.to_sym => true).first

          end_date = DateTime.parse "#{date_str} #{avail.display_end_time}" if avail

          self.booktime = start_date - 5.5.hours
          self.endtime = end_date - 5.5.hours if end_date
        rescue Exception => e
          puts e.message
        end
      end
    end

    def set_status
      accepted! if doctor && doctor.auto_accept_booking?
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

    def cancelled_by_pharmacy?
      cancelled_by_doctor?
    end

    def cancelled_by_pharmacy!
      cancelled_by_doctor!
    end

    def dept_hospital_book_type?
      self.department_booking? || self.hospital_booking?
    end

    def self.status_for_dept_hospital_booking
      @@status_for_dept_hospital_booking
    end
  end
end
