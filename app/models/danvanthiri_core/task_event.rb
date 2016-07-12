module DanvanthiriCore
  class TaskEvent < ActiveRecord::Base
    enum task_event_type: [:task, :event]
    before_validation :set_task_event_datetime
    attr_accessor :date_str, :time_str

    belongs_to :doctor
    validates :date_str, :name, :start_datetime, :description, :task_event_type, presence: true

    def set_task_event_datetime
      self.start_datetime = DateTime.parse "#{date_str} #{time_str}" if date_str.present?
    end
  end
end
