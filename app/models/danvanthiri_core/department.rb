module DanvanthiriCore
  class Department < ActiveRecord::Base
    belongs_to :hospital
    has_many :doctors, foreign_key: "department_id"
    has_many :appointments, foreign_key: "department_id", dependent: :destroy

    validates :name, presence: true
  end
end
