class CreateDhanvantriCoreServices < ActiveRecord::Migration
  def change
    create_table :dhanvantri_core_services do |t|
      t.belongs_to :dhanvantri_core_branch, index: true, foreign_key: true
      t.string :name
      t.text :description
      t.string :slug

      t.timestamps null: false
    end
  end
end
