module DanvanthiriCore
  class WorkingLocation < ActiveRecord::Base
    belongs_to :doctor
    has_many :availables, as: :owner, dependent: :destroy
    has_many :appointments, foreign_key: "working_location_id", dependent: :destroy

    validates :name, presence: true

    accepts_nested_attributes_for :availables, allow_destroy: true

    def available_ranges(date=nil)
      date ||= Date.today
      avail_on_date = availables.where(week_day: date.wday)
      morning = avail_on_date.morning.order(:start_hour)
      afternoon = avail_on_date.afternoon.order(:start_hour)
      everning = avail_on_date.everning.order(:start_hour)

      {morning: morning.map(&:display_time), afternoon: afternoon.map(&:display_time), everning: everning.map(&:display_time)}
    end

    def address
      [self.addr_street, self.addr_area, self.addr_city, self.addr_state].reject{|x| x.blank?}.join(', ')
    end

    def get_lat
      unless lat
        update_location
        self.save
      end
      lat
    end

    def get_lng
      unless lng
        update_location
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

    def update_location
      g=Geokit::Geocoders::GoogleGeocoder.geocode address
      glat = g.lat || 0
      glng = g.lng || 0
      self.lat = glat
      self.lng = glng
    end

    before_validation :check_address_change
    private
    def check_address_change
      update_location if addr_street_changed? || addr_area_changed? || addr_city_changed? || addr_state_changed?
    end
  end
end
