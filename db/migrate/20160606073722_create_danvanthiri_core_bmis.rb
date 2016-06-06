class CreateDanvanthiriCoreBmis < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_bmis do |t|
      t.string :value

      t.timestamps null: false
    end
  end
end
