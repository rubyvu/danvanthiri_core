class CreateDhanvantriCoreServices < ActiveRecord::Migration
  def change
    create_table :dhanvantri_core_services do |t|
      t.belongs_to :branch, index: true
      t.string :name
      t.text :description
      t.string :slug

      t.timestamps null: false
    end
  end
end
