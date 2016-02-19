class CreateDhanvantriCoreExperiences < ActiveRecord::Migration
  def change
    create_table :dhanvantri_core_experiences do |t|
      t.belongs_to :doctor, index: true
      t.string :position
      t.string :company
      t.integer :year_from
      t.integer :year_to

      t.timestamps null: false
    end
  end
end
