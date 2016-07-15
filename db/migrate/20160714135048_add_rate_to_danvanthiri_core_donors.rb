class AddRateToDanvanthiriCoreDonors < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_donors, :rate, :integer
  end
end
