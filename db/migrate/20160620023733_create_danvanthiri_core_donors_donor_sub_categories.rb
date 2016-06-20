class CreateDanvanthiriCoreDonorsDonorSubCategories < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_donors_donor_sub_categories do |t|
      t.integer :donor_id
      t.integer :donor_sub_category_id

      t.timestamps null: false
    end
    remove_column :danvanthiri_core_donors, :donor_sub_category_id
  end
end
