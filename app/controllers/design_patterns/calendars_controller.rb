
module DesignPatterns
  class CalendarsController < ApplicationController
    before_action :get_instance, only: %i[create_calendar]
    def create_calendar
      binding.pry
    end

    private

    def get_instance
      @client = GoogleCalendarFacade.instance(callback_url)
    end

    attr_accessor :client
  end
end
