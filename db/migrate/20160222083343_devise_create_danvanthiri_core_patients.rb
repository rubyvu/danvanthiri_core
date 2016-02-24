class DeviseCreateDanvanthiriCorePatients < ActiveRecord::Migration
  def change
    create_table(:danvanthiri_core_patients) do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.string :first_name
      t.string :last_name
      t.string :mobile_number
      t.integer :gender
      t.datetime :date_of_birth

      t.string :addr_street
      t.string :addr_area
      t.string :addr_city
      t.string :addr_state
      
      t.string :slug
      t.string :auth_token

      t.timestamps null: false
    end

    add_index :danvanthiri_core_patients, :email,                unique: true
    add_index :danvanthiri_core_patients, :reset_password_token, unique: true

  end
end
