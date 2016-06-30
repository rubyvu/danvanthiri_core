class CreateDanvanthiriCoreQuoteThreads < ActiveRecord::Migration
  def change
    create_table :danvanthiri_core_quote_threads do |t|
      t.integer :status, default: 0
      t.timestamps null: false
    end
  end
end
