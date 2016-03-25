module DanvanthiriCore
  class Patient < ActiveRecord::Base
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

    has_many :appointments, dependent: :destroy, foreign_key: "patient_id"
    has_many :likes, dependent: :destroy, foreign_key: "patient_id"
    has_many :liked_doctors, through: :likes, source: :likeable, source_type: "DanvanthiriCore::Doctor"
    has_many :social_credentials, dependent: :destroy, foreign_key: "patient_id"
    has_many :reviews, dependent: :destroy, foreign_key: "patient_id"
    has_many :activities, as: :owner

    validates :first_name, presence: true
    validates :mobile_number, presence: true, uniqueness: true, on: :update


    def liked?(obj)
      like_obj(obj).blank? ? false : true
    end

    def like_obj(obj)
      likes.where(likeable: obj).first
    end

    def phone_verified?
      otp == "1"
    end

    def in_blanklist?
      blacklist == true
    end

    def toggle_verify_otp!
      value = phone_verified? ? nil : "1"
      update_column :otp, value
    end

    def toggle_like!(obj)
      if like = like_obj(obj)
        like.destroy
      else
        liked_doctors << obj
      end
    end

    def generate_auth_token!
      begin
        self.auth_token = Devise.friendly_token
      end while self.class.exists?(auth_token: auth_token)
    end

    def clear_auth_token!
      update_column :auth_token, nil
    end

    def add_blacklist!
      update_column :blacklist, true
    end

    def remove_blacklist!
      update_column :blacklist, false
    end

    def address
      [address_line_1, address_line_2, address_city, address_state].reject{|x| x.blank?}.join(', ')
    end

    def display_otp
      phone_verified? ? "" : otp
    end

    def verify_text
      phone_verified? ? "verified" : "non-verified"
    end

    def verify_action_text
      phone_verified? ? "un-verify" : "verify"
    end

    def name
      [first_name, last_name].compact.join(" ")
    end
    
    def phone_with_country_code
      unless mobile_number.blank?
        code = country_code || "+91"
        code = code[2..-1] if code[0,2] == "00"
        code = "+#{code}" if code[0] != "+"
        number = mobile_number
        number.slice!(0) if number[0]=='0'
        "#{code}#{number}"
      end
    end

    def appointments_by_doctor(doctor)
      appointments.where(doctor: doctor)
    end
      
    def pending_appointments(doctor)
      appointments(doctor).where(status: 0)
    end

    def self.connect_facebook(token)
      begin
        @graph = Koala::Facebook::API.new(token)
        profile = @graph.get_object("me")

        if sc = SocialCredential.where(uid: profile["id"], provider: "Facebook").first
          patient = sc.patient
          return 1, patient
        else
          sc = SocialCredential.new(uid: profile["id"], provider: "Facebook")
          patient = Patient.find_by_email profile["email"]

          if patient
            sc.patient_id = patient.id
            sc.save
            return 1, patient
          else
            gender = profile["gender"].capitalize if profile["gender"]
            password = Devise.friendly_token.first(8)
            email = profile["email"] || "#{profile['id']}@facebook.com"
            patient = Patient.new email: email, first_name: profile["first_name"], last_name: profile["last_name"],
              gender: gender, password: password, password_confirmation: password
            patient.save(validate: false)
            sc.patient_id = patient.id if patient

            if sc.save
              return 2, patient
            else
              return "INV", sc.errors.full_messages
            end
          end
          
        end

      rescue Exception => e
        logger.error e.message
        return "UN-AUTHOR", ["Invalid OAuth access token"]
      end
    end

    def self.connect_google(token)
      require 'open-uri'
      begin
        url = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=#{token}"
        profile = JSON.load(open(url))
        if profile["error"]
          return "UN-AUTHOR", ["Invalid OAuth access token"]
        else
          if sc = SocialCredential.where(uid: profile["id"], provider: "Google").first
            patient = sc.patient
            return 1, patient
          else
            sc = SocialCredential.new(uid: profile["id"], provider: "Google")
            patient = Patient.find_by_email profile["email"]

            if patient
              sc.patient_id = patient.id
              sc.save
              return 1, patient
            else
              gender = profile["gender"].capitalize if profile["gender"]
              password = Devise.friendly_token.first(8)
              email = profile["email"] || "#{profile['id']}@google.com"
              patient = Patient.new email: email, first_name: profile["given_name"], last_name: profile["family_name"],
                gender: gender, password: password, password_confirmation: password
              patient.save(validate: false)
              sc.patient_id = patient.id if patient

              if sc.save
                return 2, patient
              else
                return "INV", sc.errors.full_messages
              end
            end
            
          end
        end
      rescue Exception => e
        logger.error e.message
        return "UN-AUTHOR", ["Invalid OAuth access token"]
      end
    end

  end
end
