class CreateDanvanthiriCoreDonorCategories < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_donor_categories do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
