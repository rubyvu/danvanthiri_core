class CreateDanvanthiriCorePosts < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_posts do |t|
      t.integer :owner_id
      t.string :owner_type
      t.string :title
      t.text :content
      t.boolean :public

      t.timestamps null: false
    end
  end
end
