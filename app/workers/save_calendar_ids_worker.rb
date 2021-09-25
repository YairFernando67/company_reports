# frozen_string_literal: true

class SaveCalendarIdsWorker
  include Sidekiq::Worker
  sidekiq_options retry: 2

  def perform(calendars)
    calendars.each do |calendar|
      p calendar["id"].split("@")[0]
      Redis.current.set(calendar["id"].split("@")[0], calendar["id"])
    end
  end
end
