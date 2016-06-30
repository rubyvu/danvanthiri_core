class CreateDanvanthiriCoreDoctorLineItems < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_doctor_line_items do |t|
      t.references :order
      t.integer    :quantity,                               :null => false
      t.decimal    :price,    :precision => 8, :scale => 2, :null => false
      t.string     :currency, :string
      t.timestamps null: false
    end
  end
end
