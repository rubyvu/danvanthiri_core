module DanvanthiriCore
  class PatientCoordinator < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable
    mount_uploader :avatar, ImageUploader

    has_many :patient_coordinator_categories_coordinators, foreign_key: "patient_coordinator_id", dependent: :destroy
    has_many :patient_coordinator_categories, through: :patient_coordinator_categories_coordinators
    has_many :ratings, as: :rateable, dependent: :destroy
    has_many :likes, as: :likeable, dependent: :destroy
    has_many :working_locations, as: :owner, dependent: :destroy
    has_many :appointments, dependent: :destroy, foreign_key: "patient_coordinator_id"
    has_many :availables, as: :owner, dependent: :destroy
    has_one :patient_coordinators_pc_plan, foreign_key: "patient_coordinator_id", dependent: :destroy
    has_one :pc_plan, through: :patient_coordinators_pc_plan

    def update_rating!
      update_column :rate, ratings.average(:rate)
    end

    def locations_array(date=nil)
      arr = []
      working_locations.each do |loc|
        arr << {working_location: loc.json_details(date)}
      end
      arr
    end

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
