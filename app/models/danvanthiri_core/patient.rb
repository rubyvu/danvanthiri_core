module DanvanthiriCore
  class Patient < ActiveRecord::Base
    has_many :appointments, dependent: :destroy, foreign_key: "patient_id"

    validates :first_name, :last_name, :mobile_number, presence: true
    validates :mobile_number, uniqueness: true

    def generate_auth_token!
      begin
        self.auth_token = Devise.friendly_token
      end while self.class.exists?(auth_token: auth_token)
    end

    def clear_auth_token!
      update_column :auth_token, nil
    end
    
  end
end
