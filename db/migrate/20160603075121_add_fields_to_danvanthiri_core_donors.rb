class AddFieldsToDanvanthiriCoreDonors < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_donors, :bmi, :string
    add_column :danvanthiri_core_donors, :age, :integer
  end
end
