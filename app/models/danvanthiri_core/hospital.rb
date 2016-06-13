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

    accepts_nested_attributes_for :departments, allow_destroy: true

    scope :active, -> {where active: true}
    scope :unactive, -> {where active: false}

    validates :name, presence: true

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
end
