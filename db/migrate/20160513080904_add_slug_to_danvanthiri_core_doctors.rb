class AddSlugToDanvanthiriCoreDoctors < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_doctors, :slug, :string
  end
end
