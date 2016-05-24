class AddDaysFieldsToDanvanthiriAvailables < ActiveRecord::Migration
  def change
    add_column :danvanthiri_availables, :sunday, :boolean
    add_column :danvanthiri_availables, :monday, :boolean
    add_column :danvanthiri_availables, :tuesday, :boolean
    add_column :danvanthiri_availables, :wednesday, :boolean
    add_column :danvanthiri_availables, :thursday, :boolean
    add_column :danvanthiri_availables, :friday, :boolean
    add_column :danvanthiri_availables, :saturday, :boolean
  end
end
