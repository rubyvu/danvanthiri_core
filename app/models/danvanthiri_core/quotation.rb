module DanvanthiriCore
  class Quotation < ActiveRecord::Base
    belongs_to :owner, polymorphic: true
    belongs_to :quoteable, polymorphic: true
    has_many :quote_items, dependent: :destroy, foreign_key: "quotation_id"

    accepts_nested_attributes_for :quote_items, allow_destroy: true
    validates :quote_items, presence: true

    mount_uploader :photo, ImageUploader
  end
end
