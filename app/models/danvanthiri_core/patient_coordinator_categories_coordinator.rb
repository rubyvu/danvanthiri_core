module DanvanthiriCore
  class PatientCoordinatorCategoriesCoordinator < ActiveRecord::Base
    belongs_to :patient_coordinator_category
    belongs_to :patient_coordinator
  end
end
