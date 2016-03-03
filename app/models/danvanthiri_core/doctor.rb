module DanvanthiriCore
  class Doctor < ActiveRecord::Base
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
    end

    #get info
    def address
      [addr_street, addr_area, addr_city, addr_state].reject{|x| x.blank?}.join(', ')
    end

    def available_today
      availables.where(week_day: DateTime.now.wday)
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
