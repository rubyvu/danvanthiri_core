class AddCountryCodeToDanvanthiriCorePatients < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_patients, :country_code, :string, default: "+91"
  end
end
