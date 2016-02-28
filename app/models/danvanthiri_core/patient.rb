module DanvanthiriCore
  class Patient < ActiveRecord::Base
    has_many :appointments, dependent: :destroy, foreign_key: "patient_id"
    has_many :social_credentials, dependent: :destroy, foreign_key: "patient_id"

    validates :first_name, :last_name, presence: true
    validates :mobile_number, presence: true, uniqueness: true, on: :update

    scope :active, -> {where otp: nil}
    scope :inactive, -> {where.not otp: nil}

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
          else
            gender = profile["gender"].capitalize if profile["gender"]
            password = Devise.friendly_token.first(8)
            patient = Patient.new(email: profile["email"], first_name: profile["first_name"], last_name: profile["last_name"],
              gender: gender, password: password, password_confirmation: password)
            patient.save(validate: false)
          end
          sc.patient_id = patient.if if patient
          if sc.save
            return 2, patient
          else
            return "INV", sc.errors.full_messages
          end
        end

      rescue Exception => e
        return "UN-AUTHOR", ["Invalid OAuth access token"]
      end
    end

  end
end
