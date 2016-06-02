require 'elasticsearch/model'
module DanvanthiriCore
  class Doctor < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    enum gender: [:Female, :Male]
    enum consultation_type: [:book, :call]
    enum payment_method: [:Online, :Offline, :ESC, :Cheque]
    enum payment_status: [:pending, :paid]

    mount_uploader :banner, ImageUploader
    mount_uploader :avatar, ImageUploader

    extend FriendlyId
    friendly_id :slug_candidates, use: :slugged

    def slug_candidates
      [
        [:first_name, :last_name],
        [:first_name, :last_name, :id]
      ]
    end

    def should_generate_new_friendly_id?
      slug.blank? || first_name_changed? || last_name_changed?
    end

    has_many :availables, dependent: :destroy, foreign_key: "doctor_id"
    has_many :appointments, dependent: :destroy, foreign_key: "doctor_id"

    has_many :reviews, dependent: :destroy, foreign_key: "doctor_id"
    has_many :likes, as: :likeable, dependent: :destroy
    has_many :working_locations, dependent: :destroy, foreign_key: "doctor_id"
    has_many :activities, as: :owner, dependent: :destroy
    has_many :doctors_hospitals, foreign_key: "doctor_id", dependent: :destroy
    has_many :hospitals, through: :doctors_hospitals
    has_many :posts, as: :owner, dependent: :destroy
    has_many :educations, -> { order(:created_at) }, as: :owner, dependent: :destroy
    has_many :specializations, -> { order(:created_at) }, as: :owner, dependent: :destroy
    has_many :certifications, -> { order(:created_at) }, as: :owner, dependent: :destroy
    has_many :memberships, -> { order(:created_at) }, as: :owner, dependent: :destroy
    has_many :registrations, -> { order(:created_at) }, as: :owner, dependent: :destroy
    has_many :recognitions, -> { order(:created_at) }, as: :owner, dependent: :destroy
    has_many :notifications, as: :owner, dependent: :destroy

    has_one :doctors_plan, foreign_key: "doctor_id", dependent: :destroy
    has_one :plan, through: :doctors_plan

    belongs_to :category
    belongs_to :branch

    validates :first_name, :last_name, presence: true
    validates :mobile_number, uniqueness: true, allow_nil: true
    include CustomValidation

    accepts_nested_attributes_for :working_locations, allow_destroy: true
    accepts_nested_attributes_for :educations, allow_destroy: true
    accepts_nested_attributes_for :specializations, allow_destroy: true
    accepts_nested_attributes_for :certifications, allow_destroy: true
    accepts_nested_attributes_for :memberships, allow_destroy: true
    accepts_nested_attributes_for :registrations, allow_destroy: true
    accepts_nested_attributes_for :recognitions, allow_destroy: true

    scope :verified, -> {where verified: true}

    class << self
      def custom_search(opt={})
        results = self
        opt.each do |key,val|
          unless val.blank?
            if key.to_s == 'branch_id'
              branch = DanvanthiriCore::Branch.find val
              results = by_branch(branch)
            end
          end
        end
        sort = opt[:sort] || :first_name
        results.order(sort)
      end

      def by_branch(branch)
        branch.doctors
      end

      def filter(term, filter={})
        result = Doctor
        result = Doctor.all if term.blank? && filter.blank?
        unless filter.blank?
          filter.each do |key, val|
            unless val.blank?
              result = result.where(key => val)
            end
          end
        end

        unless term.blank?
          result = result.where("
            LOWER(email) like ?
            or CONCAT(LOWER(first_name), ' ', LOWER(last_name)) like ?
            or mobile_number like ?
            or phone_number like ?
            or LOWER(clinic_name) like ?
            or LOWER(addr_street) like ?
            or LOWER(addr_area) like ?
            or LOWER(addr_city) like ?
            or LOWER(addr_state) like ?",
            "%#{term.downcase}%", "%#{term.downcase}%", "%#{term.downcase}%",
            "%#{term.downcase}%", "%#{term.downcase}%", "%#{term.downcase}%",
            "%#{term.downcase}%", "%#{term.downcase}%", "%#{term.downcase}%")
        end

        result
      end

      def fulltext_search(term, options={})
        sort = {first_name: {order: 'asc'}}
        sort = {options[:sort] => {order: 'asc'}}  unless options[:sort].blank?
        self.search("*#{term}*", size: 2000, sort: sort)
      end
    end

    def as_indexed_json(options={})
      as_json(
        only: [:id, :first_name, :last_name, :addr_street, :addr_area, :addr_city, :addr_state, :mobile_number, :phone_number,
          :about, :email, :clinic_name, :consultation_fee]
      )
    end

    #get info
    def address
      working_locations.first.address if working_locations.first
    end

    def appointments_by_patient(term=nil)
      return appointments if term.blank?
      appointments.joins(:patient).where("CONCAT(LOWER(danvanthiri_core_patients.first_name), ' ', LOWER(danvanthiri_core_patients.last_name)) like ?", "%#{term.downcase}%")
    end

    def available_ranges(date=nil)
      arr = []
      working_locations.each do |loc|
        arr << {working_location: loc.json_details(date)}
      end
      arr
    end

    def available_week_day(week_day)
      availables.where(week_day: week_day)
    end

    def name
      "#{first_name} #{last_name}"
    end

    def category_name
      category.name if category
    end

    def branch_name
      branch.name if branch
    end

    def update_rating!
      update_column :rate, reviews.average(:rate)
    end

    def generate_auth_token!
      begin
        self.auth_token = Devise.friendly_token
      end while self.class.exists?(auth_token: auth_token)
    end

    def clear_auth_token!
      update_column :auth_token, nil
    end

    def avatar_url
      self.avatar.blank? ? "#{ActionMailer::Base.default_url_options[:host]}/assets/default-user.png" : avatar
    end

    after_validation :set_verified

    protected
    def set_verified
      self.verified = true if self.payment_method == "Online"
    end

  end
end
