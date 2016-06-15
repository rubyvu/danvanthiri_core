module DanvanthiriCore
  class Hospital < ActiveRecord::Base
    mount_uploader :banner, ImageUploader

    has_many :doctors_hospitals, foreign_key: "hospital_id", dependent: :destroy
    has_many :doctors, through: :doctors_hospitals
    has_many :appointments, through: :doctors
    has_many :activities, through: :doctors
    has_many :departments, foreign_key: "hospital_id", dependent: :destroy
    has_many :hospitals_hospital_categories, foreign_key: "hospital_id", dependent: :destroy
    has_many :hospital_categories, through: :hospitals_hospital_categories

    has_many :likes, as: :likeable, dependent: :destroy
    has_many :ratings, as: :rateable, dependent: :destroy

    accepts_nested_attributes_for :departments, allow_destroy: true

    scope :active, -> {where active: true}
    scope :unactive, -> {where active: false}
    scope :premium, -> {where premium: true}

    validates :name, presence: true
    class << self
      def filter(filter={})
        result = where("1=1")
        unless filter.blank?
          filter.each do |key, val|
            unless val.blank?
              if key.to_s=='city'
                result = result.where("LOWER(addr_city) like ?", "%#{val.downcase}%")
              else
                result = result.where(key => val)
              end
            end
          end
        end

        result
      end
    end

    def active!
      update_column :active, true
    end

    def de_active!
      update_column :active, false
    end

    def address
      [addr_street, addr_area, addr_city, addr_state].reject{|x| x.blank?}.join(', ')
    end

  end

  def update_rating!
    update_column :rate, ratings.average(:rate)
  end
  
end
