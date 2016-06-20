class AddLocationToDanvanthiriCoreDonors < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_donors, :location, :string
  end
end
