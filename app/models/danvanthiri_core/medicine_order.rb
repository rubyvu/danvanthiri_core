module DanvanthiriCore
  class MedicineOrder < ActiveRecord::Base
    enum status: [:pending, :processing, :finished]
    belongs_to :owner, polymorphic: true
    belongs_to :orderable, polymorphic: true
    has_many :order_items, dependent: :destroy, foreign_key: "medicine_order_id"

    validates :orderable, :order_items, :addr_line_1, :addr_city, :addr_state, presence: true
  end
end
