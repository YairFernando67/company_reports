# frozen_string_literal: true

module DesignPatterns
  class FacadeController < ApplicationController
    def index
    end

    def google_calendar_redirect
      client = GoogleCalendarFacade.instance(callback_url)

      redirect_to client.authorization_uri
    end

    def callback
      client = GoogleCalendarFacade.instance(callback_url)
      client.set_client_code(params[:code])
      session[:authorization] = client.fetch_token

      # client.set_client_expiry(2, Time.now + 3.minutes)

      # binding.pry
      redirect_to calendars_url
    end

    def calendars
      c = GoogleCalendarFacade.instance(callback_url)
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

    def client_options
      {
        client_id: Rails.application.credentials[Rails.env.to_sym].dig(:google_calendar, :google_client_id),
        client_secret: Rails.application.credentials[Rails.env.to_sym].dig(:google_calendar, :google_client_secret),
        authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
        token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
        scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
        redirect_uri: callback_url
      }
    end
  end
end
