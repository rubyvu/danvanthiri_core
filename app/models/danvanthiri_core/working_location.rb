module DanvanthiriCore
  class WorkingLocation < ActiveRecord::Base
    belongs_to :doctor
    has_many :availables, as: :owner, dependent: :destroy
    has_many :appointments, foreign_key: "working_location_id", dependent: :destroy

    validates :name, presence: true
    validates :availables, presence: true
    validate :address_validate

    include CustomValidation
    mount_uploader :logo, ImageUploader

    accepts_nested_attributes_for :availables, allow_destroy: true

    attr_accessor :update_location_field

    def available_ranges(date=nil)
      avail_on_date = availables
      if date
        wday = date.strftime("%A").downcase
        avail_on_date = availables.send(wday)
      end
      # morning = avail_on_date.morning.order(:start_hour)
      # afternoon = avail_on_date.afternoon.order(:start_hour)
      # everning = avail_on_date.everning.order(:start_hour)
      #
      # {morning: morning.map(&:display_time), afternoon: afternoon.map(&:display_time), everning: everning.map(&:display_time)}
      availables.map(&:json_details)
    end

    def json_details(date=nil)
      {id: id, name: name, consultation_fee: consultation_fee, lat: get_lat, lng: get_lng, address: addr, addr_city: addr_city, logo: logo.url, start_date: start_date, end_date: end_date, availables: available_ranges(date)}
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

    def from_date
      start_date.blank? ? 'unknown' : start_date.strftime("%B %Y")
    end

    def to_date
      end_date.blank? ? 'present' : end_date.strftime("%B %Y")
    end

    def update_location_by_address
      g=Geokit::Geocoders::GoogleGeocoder.geocode addr
      glat = g.lat || 0
      glng = g.lng || 0
      self.lat = glat
      self.lng = glng
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
      #update_location if address_changed?
      if self.update_location_field=='lat-lng'
        update_location_by_latlng
      else
        update_location_by_address if addr_street_changed? || addr_area_changed? || addr_city_changed? || addr_state_changed?
      end
    end

    def address_validate
      if (addr_street.blank? || addr_city.blank? || addr_state.blank?) && (lat.blank? & lng.blank?)
        errors.add :base, "Either address or latitude-longitude must be provided"
      end
    end
  end
end
