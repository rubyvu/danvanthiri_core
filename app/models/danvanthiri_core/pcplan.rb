module DanvanthiriCore
  class PcPlan < ActiveRecord::Base
    has_many :patient_coordinators_pcplans, foreign_key: "pcplan_id"
    has_many :patient_coordinators, through: :patient_coordinators_pcplans
    include CustomValidation

    validates :name, presence: true
    validates :unit_price, presence: true
  end
end
