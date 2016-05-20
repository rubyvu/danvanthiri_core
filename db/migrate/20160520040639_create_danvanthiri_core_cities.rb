class CreateDanvanthiriCoreCities < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_cities do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
