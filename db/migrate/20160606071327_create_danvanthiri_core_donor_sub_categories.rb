class CreateDanvanthiriCoreDonorSubCategories < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_donor_sub_categories do |t|
      t.string :name
      t.integer :donor_category_id

      t.timestamps null: false
    end
  end
end
