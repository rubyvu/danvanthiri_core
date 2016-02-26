class CreateDanvanthiriCoreSocialCredentials < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_social_credentials do |t|
      t.integer :patient_id
      t.string :provider
      t.string :uid
      t.text :access_token

      t.timestamps null: false
    end
  end
end
