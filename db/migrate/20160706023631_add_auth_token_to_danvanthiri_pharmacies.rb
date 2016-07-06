class AddAuthTokenToDanvanthiriPharmacies < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_pharmacies, :auth_token, :string
  end
end
