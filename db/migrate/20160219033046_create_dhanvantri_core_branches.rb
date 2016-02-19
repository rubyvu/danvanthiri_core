class CreateDhanvantriCoreBranches < ActiveRecord::Migration
  def change
    create_table :dhanvantri_core_branches do |t|
      t.belongs_to :category, index: true
      t.string :name
      t.text :description
      t.string :slug

      t.timestamps null: false
    end
  end
end
