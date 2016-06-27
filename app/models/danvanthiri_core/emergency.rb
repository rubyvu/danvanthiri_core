module DanvanthiriCore
  class Emergency < ActiveRecord::Base
    enum status: [:pending, :accepted, :finished]
    belongs_to :patient

    before_create :clone_info
    def clone_info
      if patient
        self.mobile_number = patient.mobile_number
        self.email = patient.email
        self.name = patient.name
      end
    end
  end
end
