module DhanvantriCore
  class Doctor < ActiveRecord::Base
    enum gender: [:Female, :Male]

    has_many :educations, dependent: :destroy
    has_many :experiences, dependent: :destroy

    # has_many :doctors_doctor_services, dependent: :destroy
    # has_many :doctor_services, through: :doctors_doctor_services
    # has_many :doctor_sub_categories, through: :doctor_services

    # has_many :ratings, dependent: :destroy

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

    def name
      "#{first_name} #{last_name}"
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
