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
        if target.doctor_booking?
          name = target.doctor.name
        else
          name = target.hospital.name
          name = "#{name} - #{target.department.name}" if target.department
        end
        case act
          when "accepted"
            message = "Your appointment with #{name} has been accepted."
          when "cancelled", "cancelled_by_doctor"
            message = "Your appointment with #{name} has been cancelled."
          when "rejected"
            message = "Your appointment with #{name} has been rejected."
          when "finished"
            message = "Your appointment with #{name} has been finished."
        end
        update_column :message, message
        unless owner.gcm_registration.blank?
          serv = GcmService.new
          data = {notification_id: id, book_type: target.book_type, appointment_id: target_id, status: target.status, message: message}
          serv.notify(data, [owner.gcm_registration])
        end
      elsif obj_type=="Quotation"
        case act
          when "response-quote"
            quoteable = target.quoteable
            message = "#{quoteable.name} has responded to your quotation request"
          when "response-quotes"
            sample = target.quotations.last
            type = sample.quoteable_type.split('::').last
            quotes = target.quotetations.responded
            if quotes.blank?
              message = "No #{type.downcase} respond to your quotation"
            elsif quotes.count == 1
              message = "#{type} #{sample.name} have responded to your quote request"
            else
              others = quotes.count-1
              service_name = others == 1 ? type.downcase : "#{type.downcase}s"
              message = "#{type} #{sample.name} and #{others} other #{service_name} have responded to your quote request"
            end
        end

        update_column :message, message
        unless owner.gcm_registration.blank?
          serv = GcmService.new
          data = {notification_id: id, quotation_id: target_id, status: target.status, message: message}
          serv.notify(data, [owner.gcm_registration])
        end
      elsif obj_type=="MedicineOrder"
        name = "#{target.orderable_type.split("::").last}"
        name = "#{name} - #{target.orderable.name}" if target.orderable
        case act
          when "accepted"
            message = "Your MedicineOrder with #{name} has been accepted."
          when "cancelled", "cancelled_by_doctor"
            message = "Your MedicineOrder with #{name} has been cancelled."
          when "rejected"
            message = "Your MedicineOrder with #{name} has been rejected."
          when "finished"
            message = "Your MedicineOrder with #{name} has been finished."
        end
        update_column :message, message
        unless owner.gcm_registration.blank?
          serv = GcmService.new
          data = {notification_id: id, medicine_order_id: target_id, status: target.status, message: message}
          serv.notify(data, [owner.gcm_registration])
        end

      end
    end

    def read!
      update_column :read, true
    end
  end
end
