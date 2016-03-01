class AddCountryCodeToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :country_code, :string, default: "+91"
  end
end
