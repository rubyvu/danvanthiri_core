class AddPaymentToDanvanthiriCorePatientCoordinators < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_patient_coordinators, :payment_method, :integer
    add_column :danvanthiri_core_patient_coordinators, :payment_status, :integer, default: 0
  end
end
