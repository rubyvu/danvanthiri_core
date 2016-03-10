class AddIconToCategories < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_categories, :icon, :string
  end
end
