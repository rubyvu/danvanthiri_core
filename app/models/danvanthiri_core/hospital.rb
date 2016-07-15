module DanvanthiriCore
  class Hospital < ActiveRecord::Base
    mount_uploader :banner, ImageUploader
    mount_uploader :logo, ImageUploader

    has_many :doctors_hospitals, foreign_key: "hospital_id", dependent: :destroy
    has_many :doctors, through: :doctors_hospitals
    has_many :appointments, foreign_key: "hospital_id", dependent: :destroy
    has_many :activities, through: :doctors
    has_many :departments, foreign_key: "hospital_id", dependent: :destroy
    has_many :hospitals_hospital_categories, foreign_key: "hospital_id", dependent: :destroy
    has_many :hospital_categories, through: :hospitals_hospital_categories

    has_many :likes, as: :likeable, dependent: :destroy
    has_many :ratings, as: :rateable, dependent: :destroy

    has_many :certifications, -> { order(:created_at) }, as: :owner, dependent: :destroy
    has_many :registrations, -> { order(:created_at) }, as: :owner, dependent: :destroy

    has_many :quotations, as: :quoteable, dependent: :destroy

    accepts_nested_attributes_for :departments, allow_destroy: true
    accepts_nested_attributes_for :certifications, allow_destroy: true
    accepts_nested_attributes_for :registrations, allow_destroy: true

    scope :active, -> {where active: true}
    scope :unactive, -> {where active: false}
    scope :premium, -> {where premium: true}

    validates :name, presence: true
    class << self
      def filter(filter={})
        result = where("1=1")
        unless filter.blank?
          filter.each do |key, val|
            unless val.blank?
              if key.to_s == "multiple_categories"
                if val=="true"
                  result = result.joins(:hospitals_hospital_categories).group("danvanthiri_core_hospitals.id").having("count(hospital_id)>1")
                elsif val=="false"
                  result = result.joins(:hospitals_hospital_categories).group("danvanthiri_core_hospitals.id").having("count(hospital_id)=1")
                end
              elsif key.to_s=='city'
                result = result.where("LOWER(danvanthiri_core_hospitals.addr_city) like ?", "%#{val.downcase}%")
              else
                key = "danvanthiri_core_hospitals.#{key.to_s}"
                result = result.where(key => val)
              end
            end
          end
        end

        result
      end

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

    end

    def as_indexed_json(options={})
      as_json(
        only: [:id, :name]
      )
    end

    def active!
      update_column :active, true
    end

    def de_active!
      update_column :active, false
    end

    def address
      [addr_street, addr_area, addr_city, addr_state].reject{|x| x.blank?}.join(', ')
    end

    def year_ago
      return 0 unless built_year
      Date.today.year - built_year
    end

    def update_rating!
      update_column :rate, ratings.average(:rate)
    end
  end

end
