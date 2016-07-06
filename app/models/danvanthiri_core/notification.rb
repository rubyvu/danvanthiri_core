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
      data = {notification_id: id, appointment_id: target_id, status: target.status, message: message}
      unless doctor.gcm_registration.blank?
        serv = GcmService.new
        serv.notify(data, [doctor.gcm_registration])
      end

      push_ios(data) unless doctor.ios_device_token.blank?
    end

    def push_pc(act)
      patient = target.patient

      case act
        when "book"
          message = "#{patient.name} requested you for new appointment."
        when "cancelled", "cancelled_by_patient"
          message = "Your appointment with #{patient.name} has been cancelled."
        when "update"
          message = "#{patient.name} has rescheduled your appointment to #{target.booktime.strftime('%d %b, %Y')}"
      end

      update_column :message, message
      data = {notification_id: id, appointment_id: target_id, status: target.status, message: message}
    end


    def push_patient(act, obj_type="Appointment")
      data = {}
      if obj_type=="Appointment"
        if target.doctor_booking?
          name = target.doctor.name
        elsif target.medicine_booking?
          name = target.medicine_order.orderable.name
          obj_type = "Order"
        elsif target.lab_booking?
          name = target.bookable.name
        else
          name = target.hospital.name
          name = "#{name} - #{target.department.name}" if target.department
        end
        case act
          when "accepted"
            message = "Your #{obj_type} with #{name} has been accepted."
          when "cancelled", "cancelled_by_doctor"
            message = "Your #{obj_type} with #{name} has been cancelled."
          when "rejected"
            message = "Your #{obj_type} with #{name} has been rejected."
          when "finished"
            message = "Your #{obj_type} with #{name} has been finished."
        end
        update_column :message, message
        data = {notification_id: id, book_type: target.book_type, appointment_id: target_id, status: target.status, message: message}
      elsif obj_type=="Quotation"
        data = {notification_id: id, status: target.status}
        case act
          when "response-quote"
            quoteable = target.quoteable
            message = "#{quoteable.name} has responded to your quotation request"
            data[:quotation_id] = target_id
            data[:quotation_target] = target.quoteable_type.split("::").last
          when "response-quotes"
            sample = target.quotations.last
            type = sample.quoteable_type.split('::').last
            quotes = target.quotations.responded
            if quotes.blank?
              message = "No #{type.downcase} respond to your quotation"
            elsif quotes.count == 1
              message = "#{type} #{sample.quoteable.name} have responded to your quote request"
            else
              others = quotes.count-1
              service_name = others == 1 ? type.downcase : "#{type.downcase}s"
              message = "#{type} #{sample.quoteable.name} and #{others} other #{service_name} have responded to your quote request"
            end
            data[:quote_thread_id] = target_id
            data[:quotation_target] = sample.quoteable_type.split("::").last
        end

        update_column :message, message
        data[:message] = message
      end

      unless owner.gcm_registration.blank?
        serv = GcmService.new
        serv.notify(data, [owner.gcm_registration])
      end
      push_ios(data) unless owner.ios_device_token.blank?
    end

    def read!
      update_column :read, true
    end

    def push_ios(data)
      token = owner.ios_device_token
      client = Houston::Client.production
      if owner_type.include?("Doctor")
        client.certificate = File.read("#{Rails.root.to_s}/lib/danvanthiri-doctor-push-production.pem")
      else
        client.certificate = File.read("#{Rails.root.to_s}/lib/danvanthiri-patient-push-production.pem")
      end

      notification = Houston::Notification.new(device: token)
      notification.alert = data[:message]
      notification.custom_data = data

      client.push(notification)
    end
  end
end
