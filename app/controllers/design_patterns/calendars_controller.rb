
module DesignPatterns
  class CalendarsController < ApplicationController
    before_action :get_instance, only: %i[create_calendar]
    def create_calendar
      binding.pry
      client.create_calendar(calendar_params)

      redirect_to calendars_url
    end

    def delete_calendar
      client.delete_calendar(params[:calendar_id])

      redirect_to calendars_url
    end

    private

    def get_instance
      @client = GoogleCalendarFacade.instance(callback_url)
    end

    def calendar_params
      params.permit(:summary, :description)
    end

    attr_accessor :client
  end
end
