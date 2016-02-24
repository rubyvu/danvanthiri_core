class CreateDanvanthiriCoreBranchesDoctors < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_branches_doctors do |t|
      t.belongs_to :doctor
      t.belongs_to :branch

      t.timestamps null: false
    end
  end
end
