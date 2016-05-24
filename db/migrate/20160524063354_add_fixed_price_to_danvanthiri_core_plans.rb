class AddFixedPriceToDanvanthiriCorePlans < ActiveRecord::Migration
  def change
    add_column :danvanthiri_core_plans, :fixed_price, :boolean
  end
end
