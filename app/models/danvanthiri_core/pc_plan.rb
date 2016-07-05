module DanvanthiriCore
  class PcPlan < ActiveRecord::Base
    has_many :patient_coordinators_pc_plans, foreign_key: "pc_plan_id"
    has_many :patient_coordinators, through: :patient_coordinators_pc_plans

    validates :name, presence: true
    validates :unit_price, presence: true
  end
end
