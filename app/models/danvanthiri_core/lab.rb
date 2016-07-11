module DanvanthiriCore
  class Lab < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable
    mount_uploader :banner, ImageUploader
    mount_uploader :logo, ImageUploader

    belongs_to :lab_category
    has_many :certifications, -> { order(:created_at) }, as: :owner, dependent: :destroy
    has_many :likes, as: :likeable, dependent: :destroy
    has_many :ratings, as: :rateable, dependent: :destroy
    has_many :appointments, as: :bookable, dependent: :destroy
    has_many :quotations, as: :quoteable, dependent: :destroy
    
    has_many :activities, as: :owner, dependent: :destroy
    has_many :notifications, as: :owner, dependent: :destroy

    accepts_nested_attributes_for :certifications, allow_destroy: true

    scope :premium, -> {where premium: true}
    scope :by_wday, -> wday {where "#{wday}" => true}
    scope :by_date, -> date {where "#{date.strftime("%A").downcase}" => true}
    scope :verified, -> {where verified: true}

    validates :name, :mobile_number, :lab_category_id, presence: true

    class << self
      def filter(term, filter={})
        result = where("1=1")
        unless filter.blank?
          filter.each do |key, val|
            unless val.blank?
              if key.to_s=='city'
                result = result.where("LOWER(danvanthiri_core_labs.addr_city) like ?", "%#{val.downcase}%")
              else
                result = result.where(key => val)
              end
            end
          end
        end

        unless term.blank?
          result = result.where("
            LOWER(email) like ?
            or mobile_number like ?
            or phone_number like ?
            or LOWER(name) like ?
            or LOWER(addr_street) like ?
            or LOWER(addr_area) like ?
            or LOWER(addr_city) like ?
            or LOWER(addr_state) like ?",
            "%#{term.downcase}%", "%#{term.downcase}%", "%#{term.downcase}%",
            "%#{term.downcase}%", "%#{term.downcase}%", "%#{term.downcase}%",
            "%#{term.downcase}%", "%#{term.downcase}%")
        end

        result
      end
    end

    def address
      [addr_street, addr_area, addr_city, addr_state].reject{|x| x.blank?}.join(', ')
    end

    def year_ago
      return 0 unless built_year
      Date.today.year - built_year
    end

    def generate_auth_token!
      begin
        self.auth_token = Devise.friendly_token
      end while self.class.exists?(auth_token: auth_token)
    end

    def clear_auth_token!
      update_column :auth_token, nil
    end

    def update_rating!
      update_column :rate, ratings.average(:rate)
    end
  end
end
