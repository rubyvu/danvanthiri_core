module DanvanthiriCore
  class PatientCoordinatorsPcPlan < ActiveRecord::Base
    enum status:  [:pending, :active, :expired]
    belongs_to :patient_coordinator
    belongs_to :pc_plan
  end
end
