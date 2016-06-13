module DanvanthiriCore
  class Pharmacy < ActiveRecord::Base
    has_many :pharmacy_category_pharmacies, foreign_key: "pharmacy_id"
    has_many :pharmacy_categories, through: :pharmacy_category_pharmacies
    has_many :likes, as: :likeable, dependent: :destroy
    has_many :ratings, as: :rateable, dependent: :destroy

    has_many :availables, as: :owner, dependent: :destroy

    validates :name, presence: true, uniqueness: true
    validate :address_validate

    mount_uploader :logo, ImageUploader

    attr_accessor :update_location_field

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
