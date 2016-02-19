class CreateDhanvantriCoreBranches < ActiveRecord::Migration
  def change
    create_table :dhanvantri_core_branches do |t|
      t.belongs_to :dhanvantri_core_category, index: true, foreign_key: true
      t.string :name
      t.text :description
      t.string :slug

      t.timestamps null: false
    end
  end
end
