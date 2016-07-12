module DanvanthiriCore
  class TaskEvent < ActiveRecord::Base
    enum task_event_type: [:task, :event]
    before_validation :set_task_event_datetime
    before_validation :set_start_datetime

    attr_accessor :date_str, :time_str

    belongs_to :doctor
    validates :date_str, :name, :start_datetime, :description, :task_event_type, presence: true

    def set_task_event_datetime
      self.start_datetime = DateTime.parse "#{date_str} #{time_str}" if date_str.present?
    end

    def set_start_datetime
      if self.date_str
        begin
          start_datetime = DateTime.parse "#{date_str} #{time_str}"
          binding.pry
          self.start_datetime = start_datetime - 5.5.hours
        rescue Exception => e
          puts e.message
        end
      end
    end
  end
end
