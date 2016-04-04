module DanvanthiriCore
  class Plan < ActiveRecord::Base
    has_many :doctors_plans, foreign_key: "plan_id"
    has_many :doctors, through: :doctors_plans
  end
end
