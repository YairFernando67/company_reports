require "google/apis/calendar_v3"

class GoogleCalendarFacade

  private_class_method :new
  @instance_mutex = Mutex.new

  def initialize
    oauth_client
    # add_calendar_scope
  end

  class << self
    def instance
      # binding.pry
      return @client_instance if @client_instance
      @instance_mutex.synchronize do
        @client_instance ||= new
      end

      # binding.pry
      @client_instance
    end
  end

  def oauth_client
    @client = Signet::OAuth2::Client.new(client_options)
    @authorization_uri = client.authorization_uri.to_s
  end

  def set_client_code(code)
    @client.code = code
  end

  def set_client_expiry(expiry, time)
    @client.expiry = expiry
    @client.expires_at = time
  end

  def fetch_token
    @client.fetch_access_token!
  end

  def expires_at
    @client.expires_at
  end

  def update(authorization)
    @client.update!(authorization)
  end

  def get_calendar_service
    CalendarServiceFacade.instance
  end

  def add_calendar_scope
    @client.scope << Google::Apis::CalendarV3::AUTH_CALENDAR
  end

  def create_calendar(params)
    calendar = Google::Apis::CalendarV3::Calendar.new(
      summary: params[:summary],
      description: params[:description]
    )
    get_calendar_service.create_calendar(calendar)
  end

  def delete_calendar(id)
    get_calendar_service.delete_calendar(id)
  end

  def validate_token!
    if client.expires_within? 20
      token = client.refresh!
      if token
        client.update(token)
        return true
      end
      return false
    end
    return true
  end

  def logout
    client.clear_credentials!
  end

  def refresh
    binding.pry
    @client.refresh!
  end

  attr_accessor :callback, :client, :authorization_uri, :client_instance

  private

  def client_options
    {
      client_id: Rails.application.credentials[Rails.env.to_sym].dig(:google_calendar, :google_client_id),
      client_secret: Rails.application.credentials[Rails.env.to_sym].dig(:google_calendar, :google_client_secret),
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      # scope: 'email profile',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      expiry: 3,
      # expires_at: Time.now + 3.minutes,
      # additional_parameters: {
      #   response_type: 'code',
      #   include_granted_scopes: true,
      # },
      redirect_uri: "http://localhost:3000/design_patterns/facade/gmail_calendar_authorized",
      access_type: 'offline'
    }
  end

end
