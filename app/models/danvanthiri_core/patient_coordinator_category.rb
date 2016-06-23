module DanvanthiriCore
  class PatientCoordinatorCategory < ActiveRecord::Base
    has_many :patient_coordinator_categories_coordinators, foreign_key: "patient_coordinator_category_id", dependent: :destroy
    has_many :patient_coordinators, through: :patient_coordinator_categories_coordinators
  end
end
