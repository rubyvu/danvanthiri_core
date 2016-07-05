module DanvanthiriCore
  class QuoteThread < ActiveRecord::Base
    enum status: [:pending, :completed]
    has_many :quotations, dependent: :destroy, foreign_key: "quote_thread_id"
    has_many :notifications, as: :target, dependent: :destroy
  end
end
