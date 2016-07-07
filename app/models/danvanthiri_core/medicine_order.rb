module DanvanthiriCore
  class MedicineOrder < ActiveRecord::Base
    belongs_to :owner, polymorphic: true
    belongs_to :orderable, polymorphic: true
    has_many :medicine_order_items, dependent: :destroy, foreign_key: "medicine_order_id"

    accepts_nested_attributes_for :medicine_order_items, allow_destroy: true

    validates :orderable, :medicine_order_items, :addr_line_1, :addr_city, :addr_state, presence: true
    validates :delivery_time, presence: true, if: :status_is_accepted?

    def status_is_accepted?
      owner && owner.accepted?
    end

    after_validation :update_booktime

    def update_booktime
      owner.update_column :booktime, delivery_time unless owner.blank?
    end
  end
end
