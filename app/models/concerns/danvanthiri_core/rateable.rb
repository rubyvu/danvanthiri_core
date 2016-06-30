module DanvanthiriCore
  module Rateable
    extend ActiveSupport::Concern

    included do
      has_many :ratings, as: :rateable, dependent: :destroy
    end

    module ClassMethods
      
    end

    module InstanceMethods
      def update_rating!
        update_column :rate, ratings.average(:rate)
      end
    end

    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end
