module DanvanthiriCore
  class PatientCoordinator < ActiveRecord::Base
    has_many :patient_coordinator_categories_coordinators, foreign_key: "patient_coordinator_id", dependent: :destroy
    has_many :patient_coordinator_categories, through: :patient_coordinator_categories_coordinators
  end
end
