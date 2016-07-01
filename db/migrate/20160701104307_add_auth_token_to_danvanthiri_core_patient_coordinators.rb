class AddAuthTokenToDanvanthiriCorePatientCoordinators < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_patient_coordinators, :auth_token, :string
  end
end
