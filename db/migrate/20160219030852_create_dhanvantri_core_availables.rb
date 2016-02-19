class CreateDhanvantriCoreAvailables < ActiveRecord::Migration
  def change
    create_table :dhanvantri_core_availables do |t|
      t.belongs_to :doctor, index: true
      t.integer :week_day
      t.float :time_from
      t.float :time_to

      t.timestamps null: false
    end
  end
end
