module DanvanthiriCore
  class PatientCoordinatorsPcplan < ActiveRecord::Base
    enum status:  [:pending, :active, :expired]
    belongs_to :pcplan
    belongs_to :patient_coordinator
  end
end
