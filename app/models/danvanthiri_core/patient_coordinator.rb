module DanvanthiriCore
  class PatientCoordinator < ActiveRecord::Base
    has_many :patient_coordinator_categories_coordinators, foreign_key: "patient_coordinator_id", dependent: :destroy
    has_many :patient_coordinator_categories, through: :patient_coordinator_categories_coordinators
    has_many :ratings, as: :rateable, dependent: :destroy
    has_many :likes, as: :likeable, dependent: :destroy 

    def update_rating!
      update_column :rate, ratings.average(:rate)
    end
  end
end
