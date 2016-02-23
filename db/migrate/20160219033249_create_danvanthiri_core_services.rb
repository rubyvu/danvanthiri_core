class CreateDanvanthiriCoreServices < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_services do |t|
      t.belongs_to :branch, index: true
      t.string :name
      t.text :description
      t.string :slug

      t.timestamps null: false
    end
  end
end
