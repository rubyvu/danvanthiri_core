module DanvanthiriCore
  class Notification < ActiveRecord::Base
    belongs_to :owner, polymorphic: true
    belongs_to :target, polymorphic: true

    validates :owner_id, :target_id, presence: true

    def push_doctor(act)
      patient = target.patient
      doctor = target.doctor
      case act
      when "book"
        message = "#{patient.name} requested you for new appointment."
      when "cancelled", "cancelled_by_patient"
        message = "Your appointment with #{patient.name} has been cancelled."
      when "update"
        message = "#{patient.name} has rescheduled your appointment to #{target.booktime.strftime('%d %b, %Y')}"
      end

      update_column :message, message
      unless doctor.gcm_registration.blank?
        serv = GcmService.new
        data = {notification_id: id, appointment_id: target_id, status: target.status, message: message}
        serv.notify(data, [doctor.gcm_registration])
      end
    end

    def push_patient(act, obj_type="Appointment")
      if obj_type=="Appointment"
        patient = target.patient
        doctor = target.doctor
        case act
        when "accepted"
          message = "Your appointment with #{doctor.name} has been accepted."
        when "cancelled", "cancelled_by_doctor"
          message = "Your appointment with #{doctor.name} has been cancelled."
        when "rejected"
          message = "Your appointment with #{doctor.name} has been rejected."
        when "finished"
          message = "Your appointment with #{patient.name} has been finished."
        end
        update_column :message, message
        unless patient.gcm_registration.blank?
          serv = GcmService.new
          data = {notification_id: id, appointment_id: target_id, status: target.status, message: message}
          serv.notify(data, [patient.gcm_registration])
        end
      elsif obj_type=="Quotation"
        case act
        when "response-quote"
          quoteable = target.quoteable
          message = "#{quoteable.name} has responded to your quotation request"
        end

        update_column :message, message
        unless patient.gcm_registration.blank?
          serv = GcmService.new
          data = {notification_id: id, quotation_id: target_id, status: target.status, message: message}
          serv.notify(data, [patient.gcm_registration])
        end
      end

    end

    def read!
      update_column :read, true
    end
  end
end
