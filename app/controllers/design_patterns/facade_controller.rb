# frozen_string_literal: true

module DesignPatterns
  class FacadeController < ApplicationController
    CALLBACK_URL = "http://localhost:3000/design_patterns/facade/gmail_calendar_authorized".freeze
    def index
      redirect_to gmail_calendars_path if user_gmail_oauth_active?
    end

    def gmail_login
      client = GoogleCalendarFacade.instance
      # binding.pry
      if user_gmail_oauth_active?
        if client.valid_token?(current_user.refresh_token)
          return redirect_to gmail_calendars_path
        else
          return redirect_to client.authorization_uri
        end
      else
        redirect_to client.authorization_uri
      end
    end

    def gmail_calendar_authorized
      client = GoogleCalendarFacade.instance
      client.set_client_code(params[:code])
      token = client.fetch_token
      client.update(token)
      # binding.pry
      current_user.update(gmail_oauth: true, refresh_token: token["access_token"])

      redirect_to gmail_calendars_url
    end

    def gmail_logout
      current_user.update(gmail_oauth: false, refresh_token: "")
      GoogleCalendarFacade.instance.logout

      redirect_to facade_path
    end

    private

    def user_gmail_oauth_active?
      current_user.gmail_oauth && current_user.refresh_token
    end
  end
end
