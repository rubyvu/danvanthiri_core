require 'elasticsearch/model'
module DanvanthiriCore
  class Doctor < ActiveRecord::Base
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    enum gender: [:Female, :Male]
    enum consultation_type: [:book, :call]

    has_many :availables, dependent: :destroy, foreign_key: "doctor_id"
    has_many :appointments, dependent: :destroy, foreign_key: "doctor_id"

    has_many :branches_doctors, dependent: :destroy, foreign_key: "doctor_id"
    has_many :branches, through: :branches_doctors
    has_many :reviews, dependent: :destroy, foreign_key: "doctor_id"
    has_many :likes, as: :likeable, dependent: :destroy

    validates :first_name, :last_name, presence: true

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

      def fulltext_search(term, options={})
        sort = {first_name: {order: 'asc'}}
        sort = {options[:sort] => {order: 'asc'}}  unless options[:sort].blank?
        self.search("*#{term}*", size: 2000, sort: sort)
      end
    end

    def as_indexed_json(options={})
      as_json(
        only: [:id, :first_name, :last_name, :addr_street, :addr_area, :addr_city, :addr_state, :mobile_number, :phone_number,
          :about, :certification, :registration, :email, :clinic_name, :consultation_fee]
      )
    end

    #get info
    def address
      [addr_street, addr_area, addr_city, addr_state].reject{|x| x.blank?}.join(', ')
    end

    def available_today
      availables.where(week_day: DateTime.now.wday)
    end

    def available_ranges
      available_today.order(:time_from).map(&:display_time)
    end


    def available_week_day(week_day)
      availables.where(week_day: week_day)
    end

    def name
      "#{first_name} #{last_name}"
    end

    def branch_names
      branches.map(&:name).join(", ")
    end

    def update_rating!
      update_column :rate, reviews.average(:rate)
    end

    # def services
    #   doctor_services.map(&:name).join(", ")
    # end

    # def update_services(services)
    #   self.doctor_services = services
    #   self.doctor_category_id = services.first.doctor_category.id unless services.blank?
    #   self.save
    # end

    # def update_rating!
    #   update_column :rate, ratings.average(:value) 
    # end
  end
end
