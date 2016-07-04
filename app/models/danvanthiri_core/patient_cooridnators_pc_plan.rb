module DanvanthiriCore
  class PatientCoordinatorsPcPlan < ActiveRecord::Base
    enum status:  [:pending, :active, :expired]
  end
end
