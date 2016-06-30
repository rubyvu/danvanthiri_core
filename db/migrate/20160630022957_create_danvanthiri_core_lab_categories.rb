class CreateDanvanthiriCoreLabCategories < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_lab_categories do |t|
      t.string :name
      t.string :logo
      t.text :welcome_message

      t.timestamps null: false
    end
  end
end
