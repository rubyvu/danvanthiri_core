class CreateDanvanthiriCoreCaseHistories < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_case_histories do |t|
      t.text :content
      t.integer :quotation_id

      t.timestamps null: false
    end
  end
end
