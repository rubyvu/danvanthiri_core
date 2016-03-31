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
      [addr_street, addr_area, addr_city, addr_state].reject{|x| x.blank?}.join(', ')
    end
  end
end
