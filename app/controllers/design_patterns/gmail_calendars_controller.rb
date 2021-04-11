
module DesignPatterns
  class GmailCalendarsController < ApplicationController
    before_action :get_instance, only: %i[create_calendar delete_calendar]
    before_action :validate_token, only: %i[create_calendar delete_calendar]
    CALLBACK_URL = "http://localhost:3000/design_patterns/facade/calendar_authorized".freeze
    def create_calendar
      # binding.pry
      client.create_calendar(calendar_params)

      redirect_to gmail_calendars_url
    end

    def delete_calendar
      client.delete_calendar(params[:calendar_id])

      redirect_to gmail_calendars_url
    # rescue Google::Apis::AuthorizationError
    #   binding.pry
    #   response = client.refresh

    #   session[:authorization] = session[:authorization].merge(response)

    #   retry
    end

    def gmail_calendars
      c = GoogleCalendarFacade.instance
      c.update(session[:authorization])

      s = c.get_calendar_service
      s.set_authorization(c.client)

      @calendar_list = s.get_calendar_list
      # binding.pry
    rescue Google::Apis::AuthorizationError
      # binding.pry
      response = c.refresh

      session[:authorization] = session[:authorization].merge(response)

      retry
    end

    def events
      client = Signet::OAuth2::Client.new(client_options)
      # binding.pry
      # client.update!(session[:authorization], :additional_parameters => {"access_type" => "offline"})
      client.update!(session[:authorization])
      # binding.pry
      service = Google::Apis::CalendarV3::CalendarService.new
      service.authorization = client

      @event_list = service.list_events(params[:calendar_id])
    end

    def new_event
      client = Signet::OAuth2::Client.new(client_options)
      client.update!(session[:authorization])

      service = Google::Apis::CalendarV3::CalendarService.new
      service.authorization = client

      today = Date.today

      event = Google::Apis::CalendarV3::Event.new({
        start: Google::Apis::CalendarV3::EventDateTime.new(date: today),
        end: Google::Apis::CalendarV3::EventDateTime.new(date: today + 1),
        summary: 'New event!'
      })

      service.insert_event(params[:calendar_id], event)

      redirect_to events_url(calendar_id: params[:calendar_id])
    end

    private

    def get_instance
      @client = GoogleCalendarFacade.instance
    end

    def validate_token
      # binding.pry
      if !client.validate_token!
        redirect_to client.authorization_uri
      end
    end

    def calendar_params
      params.permit(:summary, :description)
    end

    def client_options
      {
        client_id: Rails.application.credentials[Rails.env.to_sym].dig(:google_calendar, :google_client_id),
        client_secret: Rails.application.credentials[Rails.env.to_sym].dig(:google_calendar, :google_client_secret),
        authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
        token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
        scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
        redirect_uri: CALLBACK_URL
      }
    end

    attr_accessor :client
  end
end
