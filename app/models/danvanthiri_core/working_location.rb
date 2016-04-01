module DanvanthiriCore
  class WorkingLocation < ActiveRecord::Base
    belongs_to :doctor
    has_many :availables, foreign_key: "working_location_id", dependent: :destroy
    has_many :appointments, foreign_key: "working_location_id", dependent: :destroy

    validates :name, presence: true

    accepts_nested_attributes_for :availables, allow_destroy: true

    def available_ranges(date=nil)
      date ||= Date.today
      avail_on_date = availables.where(week_day: date.wday)
      morning = avail_on_date.where("time_from < 12.0").order(:time_from)
      afternoon = avail_on_date.where("time_from >= 12.0 and time_from < 17.0").order(:time_from)
      everning = avail_on_date.where("time_from >= 17.0").order(:time_from)

      {morning: morning.map(&:display_time), afternoon: afternoon.map(&:display_time), everning: everning.map(&:display_time)}
    end

    def address
      [self.addr_street, self.addr_area, self.addr_city, self.addr_state].reject{|x| x.blank?}.join(', ')
    end

    before_validation :update_location

    def update_location
      if addr_street_changed? || addr_area_changed? || addr_city_changed? || addr_state_changed?
        g=Geokit::Geocoders::GoogleGeocoder.geocode address
        glat = g.lat || 0
        glng = g.lng || 0
        self.lat = glat
        self.lng = glng
      end
    end
  end
end
