class AddAboutToDanvanthiriCoreLabs < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_labs, :about, :text
  end
end
