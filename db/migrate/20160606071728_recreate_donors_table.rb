class RecreateDonorsTable < ActiveRecord::Migration
  def change
    rename_column :danvanthiri_core_donors, :category, :donor_category_id
    rename_column :danvanthiri_core_donors, :sub_category, :donor_sub_category_id
    rename_column :danvanthiri_core_donors, :bmi, :bmi_id
    rename_column :danvanthiri_core_donor_requests, :category, :donor_category_id
    rename_column :danvanthiri_core_donor_requests, :sub_category, :donor_sub_category_id
  end
end
