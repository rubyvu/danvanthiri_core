module DanvanthiriCore
  class Lab < ActiveRecord::Base
    included Rateable
    mount_uploader :banner, ImageUploader
    mount_uploader :logo, ImageUploader

    belongs_to :lab_category
    has_many :certifications, -> { order(:created_at) }, as: :owner, dependent: :destroy

    accepts_nested_attributes_for :certifications, allow_destroy: true

    scope :premium, -> {where premium: true}
    scope :by_wday, -> wday {where "#{wday}" => true}
    scope :by_date, -> date {where "#{date.strftime("%A").downcase}" => true}

    validates :name, :phone_number, presence: true

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
            or phone_number like ?
            or LOWER(name) like ?
            or LOWER(addr_street) like ?
            or LOWER(addr_area) like ?
            or LOWER(addr_city) like ?
            or LOWER(addr_state) like ?",
            "%#{term.downcase}%", "%#{term.downcase}%", "%#{term.downcase}%",
            "%#{term.downcase}%", "%#{term.downcase}%", "%#{term.downcase}%",
            "%#{term.downcase}%", "%#{term.downcase}%")
        end

        result
      end
    end

    def address
      [addr_street, addr_area, addr_city, addr_state].reject{|x| x.blank?}.join(', ')
    end

    def year_ago
      return 0 unless built_year
      Date.today.year - built_year
    end

  end
end
