module DanvanthiriCore
  class PatientCoordinator < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

    mount_uploader :avatar, ImageUploader
    validates :first_name, :last_name, presence: true
    validates :mobile_number, uniqueness: true, allow_blank: true

    enum gender: [:Female, :Male]
    enum payment_method: [:Online, :Offline]
    enum payment_status: [:pending, :paid]

    has_many :patient_coordinator_categories_coordinators, foreign_key: "patient_coordinator_id", dependent: :destroy
    has_many :patient_coordinator_categories, through: :patient_coordinator_categories_coordinators
    has_many :ratings, as: :rateable, dependent: :destroy
    has_many :likes, as: :likeable, dependent: :destroy
    has_many :working_locations, as: :owner, dependent: :destroy
    has_many :appointments, dependent: :destroy, foreign_key: "patient_coordinator_id"
    has_many :availables, as: :owner, dependent: :destroy
    has_many :notifications, as: :owner, dependent: :destroy

    has_one :patient_coordinators_pcplan, foreign_key: "patient_coordinator_id", dependent: :destroy
    has_one :pcplan, through: :patient_coordinators_pcplan


    accepts_nested_attributes_for :availables, allow_destroy: true
    accepts_nested_attributes_for :working_locations, allow_destroy: true
    scope :published, -> {where published: true}


    class << self
      def inherited(child)
        super
        child.instance_eval do
          include Elasticsearch::Model
          include Elasticsearch::Model::Callbacks
        end
      end

      def fulltext_search(term, options={})
        sort = {name: {order: 'asc'}}
        sort = {options[:sort] => {order: 'asc'}}  unless options[:sort].blank?
        self.search("*#{term}*", size: 2000, sort: sort)
      end

      def by_city(city)
        includes(:working_locations).where("danvanthiri_core_working_locations.addr_city=?", city).references(:working_locations)
      end
    end

    def as_indexed_json(options={})
      as_json(
        only: [:id, :name, :cities, :categories],
        methods: [:name, :cities, :categories]
      )
    end

    def categories
      patient_coordinator_categories.map(&:name).join(", ")
    end

    def cities
      working_locations.map(&:addr_city).join(", ")
    end

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

    def name
      "#{first_name} #{last_name}"
    end

  end
end
