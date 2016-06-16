module DanvanthiriCore
  class HospitalAppointment < ActiveRecord::Base
    enum status: [:pending, :accepted, :finished, :expired, :rescheduled, :cancelled_by_patient, :cancelled_by_hospital, :rejected]
    belongs_to :patient
    belongs_to :hospital
    belongs_to :bookable, polymorphic: true

    has_many :notifications, as: :target, dependent: :destroy

    validates :booktime, :patient, :hospital, :bookable, presence: true

    attr_accessor :date_str, :time_str

    scope :pending, -> {where status: 0}
    scope :accepted, -> {where status: 1}
    scope :finished, -> {where status: 2}
    scope :cancelled, -> {where status: 3}

    scope :past, -> {where("booktime < ?", DateTime.now)}
    scope :upcomming, -> {where("booktime > ?", DateTime.now)}

    class << self
      def filter(term, filter={})
        result = where("1=1")
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
          result = result.joins(:patient, :hospital).where("
            LOWER(danvanthiri_core_hospitals.name) like ?
            or CONCAT(LOWER(danvanthiri_core_patients.first_name), ' ', LOWER(danvanthiri_core_patients.last_name)) like ?",
            "%#{term.downcase}%", "%#{term.downcase}%")
        end

        result
      end
    end


    before_validation :set_booking_time

    def set_booking_time
      unless self.bookable_type.blank?
        self.bookable_type = "DanvanthiriCore::#{self.bookable_type.captitalize}" unless self.bookable_type.include?("DanvanthiriCore")
      end
      if self.date_str && self.time_str && self.bookable_id && self.hospital_id
        begin
          start_date = DateTime.parse "#{date_str} #{time_str}"
          wday = start_date.strftime("%A").downcase

          arr = self.time_str.split(":")
          avail = self.hospital.availables.where(start_hour: arr.first.to_i, start_min: arr.last.to_i, wday.to_sym => true).first

          end_date = DateTime.parse "#{date_str} #{avail.display_end_time}" if avail

          self.booktime = start_date - 5.5.hours
          self.endtime = end_date - 5.5.hours if end_date
        rescue Exception => e
          puts e.message
        end
      end
    end

    def patient_name
      patient.name if patient
    end

    def hospital_name
      hospital.name if hospital
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
