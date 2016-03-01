module DanvanthiriCore
  class Patient < ActiveRecord::Base
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

    has_many :appointments, dependent: :destroy, foreign_key: "patient_id"
    has_many :social_credentials, dependent: :destroy, foreign_key: "patient_id"
    has_many :reviews, dependent: :destroy, foreign_key: "patient_id"
    
    validates :first_name, presence: true
    validates :mobile_number, presence: true, uniqueness: true, on: :update

    scope :active, -> {where otp: nil}
    scope :inactive, -> {where.not otp: nil}

    def active?
      otp.blank?
    end

    def address
      [address_line_1, address_line_2, address_city, address_state].reject{|x| x.blank?}.join(', ')
    end

    def name
      [first_name, last_name].compact.join(" ")
    end
    
    def phone_with_country_code
      unless mobile_number.blank?
        code = country_code || "+91"
        if code[0,2] == "00"
          code = "+" + code[2..-1]
        end
        number = mobile_number.slice!(0) if number[0]=='0'
        "#{code}#{phone_number}"
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
            patient.otp = rand(10000..99999) 
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
              patient.otp = rand(10000..99999) 
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
