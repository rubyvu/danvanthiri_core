module DanvanthiriCore
  class Activity < ActiveRecord::Base
    belongs_to :owner, polymorphic: true
    belongs_to :related_obj, polymorphic: true

    class << self
      def record_login(owner)
        owner.activities.create(log_type: "login")
      end

      def record_signup(owner)
        owner.activities.create(log_type: "signup")
      end

      def record_booking(owner, appointment, act)
        owner.activities.create(log_type: act, related_obj: appointment)
      end

      def record_click(owner, doctor)
        activity = owner.activities.find_or_create_by related_obj: doctor, log_type: "click"
        activity.value = activity.value.blank? ? 1 : activity.value+1
      end
    end
  end
end
