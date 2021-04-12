require "google/apis/calendar_v3"

class GoogleCalendarFacade

  private_class_method :new
  @instance_mutex = Mutex.new

  def initialize
    oauth_client
  end

  class << self
    def instance()
      return @client_instance if @client_instance
      @instance_mutex.synchronize do
        @client_instance ||= new
      end

      @client_instance
    end
  end

  def oauth_client
    @client = Signet::OAuth2::Client.new(client_options)
    @client.expires_at = Time.now + 10.seconds
    @authorization_uri = client.authorization_uri.to_s
  end

  def set_client_code(code)
    @client.code = code
  end

  def fetch_token
    client.fetch_access_token!
  end

  def expires_at
    @client.expires_at
  end

  def update(token)
    @client.update!(token)
  end

  def get_calendar_service
    @get_calendar_service ||= Google::Apis::CalendarV3::CalendarService.new
  end

  def add_calendar_scope
    @client.scope << Google::Apis::CalendarV3::AUTH_CALENDAR
  end

  def create_calendar(params)
    calendar = Google::Apis::CalendarV3::Calendar.new(
      summary: params[:summary],
      description: params[:description]
    )
    get_calendar_service.insert_calendar(calendar)
  end

  def delete_calendar(id)
    get_calendar_service.delete_calendar(id + "@group.calendar.google.com")
  end

  def gmail_calendars
    service = get_calendar_service
    service.authorization = client
    service.list_calendar_lists
  end

  def get_events(id)
    service = get_calendar_service
    service.authorization = client
    service.list_events(id + "@group.calendar.google.com")
  end

  def valid_token?(auth_token)
    return false unless client
    if token_expired? || client.access_token.nil?
      token = refresh_token(auth_token)
      client.update!(token)
    end
    true
  rescue Signet::AuthorizationError
    return false
  end

  def refresh_token(token)
    client.grant_type = "refresh_token"
    client.refresh_token = token
    client.refresh!
  end

  def token_expired?
    return true if client.expires_at.nil?

    Time.now >= client.expires_at
  end

  def logout
    @client_instance = nil
  end

  attr_accessor :callback, :client, :authorization_uri, :client_instance, :gmail_oauth

  private

  def client_options
    {
      client_id: Rails.application.credentials[Rails.env.to_sym].dig(:google_calendar, :google_client_id),
      client_secret: Rails.application.credentials[Rails.env.to_sym].dig(:google_calendar, :google_client_secret),
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      additional_parameters: {
        response_type: 'code',
        include_granted_scopes: true,
      },
      redirect_uri: "http://localhost:3000/design_patterns/facade/gmail_calendar_authorized",
      access_type: 'offline'
    }
  end
end
