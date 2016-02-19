class CreateDhanvantriCoreCategories < ActiveRecord::Migration
  def change
    create_table :dhanvantri_core_categories do |t|
      t.string :name
      t.text :description
      t.string :slug

      t.timestamps null: false
    end
  end
end
