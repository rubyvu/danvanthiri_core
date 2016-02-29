class CreateDanvanthiriCoreReviews < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_reviews do |t|
      t.integer :patient_id
      t.integer :doctor_id
      t.text :content
      t.integer :rate, default: 0

      t.timestamps null: false
    end
  end
end
