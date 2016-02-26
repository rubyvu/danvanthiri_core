class CreateDanvanthiriCoreOneTimeTokens < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_one_time_tokens do |t|
      t.string :mobile_number
      t.string :otp

      t.timestamps null: false
    end
  end
end
