class AddDaysFieldsToDanvanthiriAvailables < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_availables, :sunday, :boolean
    add_column :danvanthiri_core_availables, :monday, :boolean
    add_column :danvanthiri_core_availables, :tuesday, :boolean
    add_column :danvanthiri_core_availables, :wednesday, :boolean
    add_column :danvanthiri_core_availables, :thursday, :boolean
    add_column :danvanthiri_core_availables, :friday, :boolean
    add_column :danvanthiri_core_availables, :saturday, :boolean
  end
end
