class CreateDanvanthiriCoreDonorRequestsDonorSubCategories < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_donor_requests_donor_sub_categories do |t|
      t.integer :donor_request_id
      t.integer :donor_sub_category_id

      t.timestamps null: false
    end
  end
end
