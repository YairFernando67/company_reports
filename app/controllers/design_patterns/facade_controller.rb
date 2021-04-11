# frozen_string_literal: true

module DesignPatterns
  class FacadeController < ApplicationController
    CALLBACK_URL = "http://localhost:3000/design_patterns/facade/gmail_calendar_authorized".freeze
    def index
    end

    def gmail_login
      token = session[:authorization]
      if token
        # binding.pry
        if Time.now >= token["expires_at"]
          client = GoogleCalendarFacade.instance
          redirect_to client.authorization_uri
        else
          redirect_to gmail_calendars_path
        end
      else
        client = GoogleCalendarFacade.instance
        redirect_to client.authorization_uri
      end

      # client = GoogleCalendarFacade.instance
      # if client.validate_token!
      #   redirect_to gmail_calendars_path
      # else
      #   redirect_to client.authorization_uri
      # end
      # client = GoogleCalendarFacade.instance
      # redirect_to client.authorization_uri
    end

    def gmail_calendar_authorized
      client = GoogleCalendarFacade.instance
      client.set_client_code(params[:code])
      # binding.pry
      token = client.fetch_token
      token[:expires_at] = client.expires_at
      session[:authorization] = token
      # binding.pry

      # client.set_client_expiry(2, Time.now + 3.minutes)

      # binding.pry
      redirect_to gmail_calendars_url
    end

    def gmail_logout
      session[:authorization] = nil
      GoogleCalendarFacade.instance.logout
      redirect_to facade_path
    end
  end
end
