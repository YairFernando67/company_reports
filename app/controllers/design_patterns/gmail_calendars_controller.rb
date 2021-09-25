# frozen_string_literal: true

module DesignPatterns
  class GmailCalendarsController < ApplicationController
    before_action :get_instance, only: %i[create_calendar delete_calendar gmail_calendars events]
    before_action :valid_token, only: %i[create_calendar delete_calendar gmail_calendars events]
    CALLBACK_URL = "http://localhost:3000/design_patterns/facade/calendar_authorized"

    def create_calendar
      client.create_calendar(calendar_params)
      redirect_to gmail_calendars_url
    end

    def delete_calendar
      client.delete_calendar(params[:calendar_id])
      redirect_to gmail_calendars_url
    end

    def gmail_calendars
      @calendar_list = client.gmail_calendars
    end

    def events
      @event_list = client.get_events(params[:calendar_id], current_user)
      respond_to do |f|
        f.html
        f.js
        f.json
      end
    end

    def new_event
      client = Signet::OAuth2::Client.new(client_options)
      client.update!(session[:auth_token])

      service = Google::Apis::CalendarV3::CalendarService.new
      service.authorization = client

      today = Date.today

      event = Google::Apis::CalendarV3::Event.new(
        start: Google::Apis::CalendarV3::EventDateTime.new(date: today),
        end: Google::Apis::CalendarV3::EventDateTime.new(date: today + 1),
        summary: "New event!"
      )

      service.insert_event(params[:calendar_id], event)

      redirect_to events_url(calendar_id: params[:calendar_id])
    end

    private

    def get_instance
      @client = GoogleCalendarFacade.instance
    end

    def valid_token
      redirect_to client.authorization_uri unless client.valid_token?(current_user.refresh_token)
    end

    def calendar_params
      params.permit(:summary, :description)
    end

    def client_options
      {
        client_id: Rails.application.credentials[Rails.env.to_sym].dig(:google_calendar, :google_client_id),
        client_secret: Rails.application.credentials[Rails.env.to_sym].dig(:google_calendar, :google_client_secret),
        authorization_uri: "https://accounts.google.com/o/oauth2/auth",
        token_credential_uri: "https://accounts.google.com/o/oauth2/token",
        scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
        redirect_uri: CALLBACK_URL
      }
    end

    attr_accessor :client
  end
end
