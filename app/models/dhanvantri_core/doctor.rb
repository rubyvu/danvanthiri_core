module DhanvantriCore
  class Doctor < ActiveRecord::Base
    enum gender: [:Female, :Male]
    enum consultation_type: [:book, :call]

    has_many :availables, dependent: :destroy, foreign_key: "doctor_id"
    has_many :educations, dependent: :destroy, foreign_key: "doctor_id"
    has_many :experiences, dependent: :destroy, foreign_key: "doctor_id"

    has_many :doctors_services, dependent: :destroy, foreign_key: "doctor_id"
    has_many :services, through: :doctors_services
    has_many :branchs, through: :services
    #has_many :ratings, dependent: :destroy, foreign_key: "doctor_id"

    validates :first_name, :last_name, presence: true

    class << self
      def custom_search(opt={})
        results = self
        opt.each do |key,val|
          unless val.blank?
            if key.to_s == 'doctor_service_id'
              service = DoctorService.find val
              results = by_service(service)
            elsif key.to_s = 'doctor_sub_category_id'
              sub_category = DoctorSubCategory.find val
              results = by_sub_category(sub_category)
            end
          end
        end
        sort = opt[:sort] || :first_name
        results.order(sort)
      end

      def by_service(service)
        service.doctors
      end

      def by_sub_category(sub_category)
        sub_category.doctors
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

    def registrations
      [registration_at, registration_year].reject{|x| x.blank?}.join(", ")
    end

    def service_names
      services.map(&:name).join(", ")
    end

    # def update_rating!
    #   update_column :rate, ratings.average(:value) 
    # end

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
