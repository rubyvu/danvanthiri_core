module DanvanthiriCore
  class QuoteThread < ActiveRecord::Base
    enum status: [:pending, :completed]
    has_many :quotations, dependent: :destroy, foreign_key: "quote_thread_id"
  end
end
