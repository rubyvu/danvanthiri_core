class ChangeAvailables < ActiveRecord::Migration
  def change
    remove_column :danvanthiri_core_availables, :time_from, :string
    remove_column :danvanthiri_core_availables, :time_to, :string

    add_column :danvanthiri_core_availables, :start_hour, :integer
    add_column :danvanthiri_core_availables, :start_min, :integer
    add_column :danvanthiri_core_availables, :end_hour, :integer
    add_column :danvanthiri_core_availables, :end_min, :integer
  end
end
