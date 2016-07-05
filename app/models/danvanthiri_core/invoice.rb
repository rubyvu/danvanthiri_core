module DanvanthiriCore
  class Invoice < ActiveRecord::Base
    has_many :invoice_items, dependent: :destroy
    accepts_nested_attributes_for :invoice_items, allow_destroy: true
    validates :email, uniqueness: true
    validates :invoice_items, presence: true

    enum status [:pending, :completed, :failed]

    def mark_complete
      self.status = :completed
      self.save
      touch :completed_at
    end

    def mark_fail
      self.status = :failed
      self.save
    end

  end
end
