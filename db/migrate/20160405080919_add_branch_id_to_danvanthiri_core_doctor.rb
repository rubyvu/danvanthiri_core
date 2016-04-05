class AddBranchIdToDanvanthiriCoreDoctor < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_doctors, :branch_id, :integer
  end
end
