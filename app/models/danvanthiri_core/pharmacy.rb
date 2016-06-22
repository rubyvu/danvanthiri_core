module DanvanthiriCore
  class Pharmacy < ActiveRecord::Base
    belongs_to :pharmacy_category
    has_many :likes, as: :likeable, dependent: :destroy
    has_many :ratings, as: :rateable, dependent: :destroy
    has_many :availables, as: :owner, dependent: :destroy
    has_many :quotations, as: :quoteable, dependent: :destroy
    has_many :medicine_orders, as: :orderable, dependent: :destroy
    
    validates :name, presence: true, uniqueness: true
    validates :email, :mobile_number, :pharmacy_category_id, :certification, :license, presence: true
    validate :address_validate

    accepts_nested_attributes_for :availables, allow_destroy: true

    mount_uploader :logo, ImageUploader
    mount_uploader :banner, ImageUploader

    attr_accessor :update_location_field

    scope :banner_status, -> {where banner_status: true}
    class << self

      def filter(term, filter={})
        result = Pharmacy
        result = Pharmacy.all if term.blank? && filter.blank?
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
            or mobile_number like ?
            or LOWER(name) like ?
            or LOWER(addr_street) like ?
            or LOWER(addr_area) like ?
            or LOWER(addr_city) like ?
            or LOWER(addr_state) like ?",
            "%#{term.downcase}%", "%#{term.downcase}%", "%#{term.downcase}%",
            "%#{term.downcase}%", "%#{term.downcase}%", "%#{term.downcase}%",
            "%#{term.downcase}%")
        end

        result
      end

    end

    def update_rating!
      update_column :rate, ratings.average(:rate)
    end

    def available_ranges(date=nil)
      avail_on_date = availables
      if date
        wday = date.strftime("%A").downcase
        avail_on_date = availables.send(wday)
      end
      availables.map(&:json_details)
    end

    def addr
      [self.addr_street, self.addr_area, self.addr_city, self.addr_state].reject{|x| x.blank?}.join(', ')
    end

    def get_lat
      unless lat
        update_location_by_address
        self.save
      end
      lat
    end

    def get_lng
      unless lng
        update_location_by_address
        self.save
      end
      lng
    end

    def update_location_by_address
      g=Geokit::Geocoders::GoogleGeocoder.geocode addr
      self.lat = g.lat
      self.lng = g.lng
    end

    def update_location_by_latlng
      g=Geokit::Geocoders::GoogleGeocoder.geocode "#{self.lat},#{self.lng}"
      self.addr_street = g.street_name
      self.addr_area = g.district
      self.addr_city = g.city
      self.addr_state = g.state_name
    end

    before_validation :check_address_change
    private
    def check_address_change
      if self.update_location_field=='lat-lng'
        update_location_by_latlng
      else
        update_location_by_address if addr_street_changed? || addr_area_changed? || addr_city_changed? || addr_state_changed?
      end
    end
    def address_validate
      if (addr_street.blank? || addr_city.blank? || addr_state.blank?) && (lat.blank? & lng.blank?)
        errors.add :address, "or latitude-longitude must be provided"
      end
    end
  end
end
