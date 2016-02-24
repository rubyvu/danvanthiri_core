class CreateDanvanthiriCoreDoctors < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_doctors do |t|
      t.string :first_name
      t.string :last_name
      t.integer :gender
      t.string :avatar
      t.integer :year_of_experience
      t.integer :consultation_fee

      t.string :addr_street
      t.string :addr_area
      t.string :addr_city
      t.string :addr_state
      t.string :mobile_number

      t.text :about
      t.text :certification
      t.string :registration

      t.float :rate

      t.timestamps null: false
    end
  end
end
