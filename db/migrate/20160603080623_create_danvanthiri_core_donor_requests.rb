class CreateDanvanthiriCoreDonorRequests < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_donor_requests do |t|
      t.string :category
      t.string :sub_category
      t.string :blood_group
      t.string :location
      t.datetime :request_date
      t.integer :owner_id
      t.string :owner_type

      t.timestamps null: false
    end
  end
end
