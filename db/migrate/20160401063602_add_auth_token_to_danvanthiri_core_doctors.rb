class AddAuthTokenToDanvanthiriCoreDoctors < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_doctors, :auth_token, :string
    add_column :danvanthiri_core_doctors, :otp, :string
    add_column :danvanthiri_core_doctors, :phone_verified, :boolean
  end
end
