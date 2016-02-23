class CreateDanvanthiriCoreDoctors < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_doctors do |t|
      t.string :first_name
      t.string :last_name
      t.integer :gender
      t.string :avatar
      t.text :specializations
      t.integer :year_of_experience
      t.string :clinic
      t.integer :consultation_fee
      t.integer :consultation_type
      t.string :addr_street
      t.string :addr_area
      t.string :addr_city
      t.string :addr_state
      t.string :phone_number
      t.text :description
      t.text :memberships
      t.text :awards
      t.string :registration_at
      t.integer :registration_year
      t.float :rate
      t.string :facebook
      t.string :twitter
      t.string :linkedin
      t.string :google_plus

      t.timestamps null: false
    end
  end
end
