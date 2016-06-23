class CreateDanvanthiriCorePatientCoordinators < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_patient_coordinators do |t|
      t.string :name
      t.string :avatar
      t.string :banner
      t.integer :year_of_experience
      t.string :mobile_number
      t.string :location
      t.string :working_time
      t.string :awards_recognitions
      t.string :primary_language
      t.string :language_know
      t.text :about

      t.timestamps null: false
    end
  end
end
