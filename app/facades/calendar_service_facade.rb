class CalendarServiceFacade
  private_class_method :new
  @instance_mutex = Mutex.new

  def initialize
    @calendar_service = Google::Apis::CalendarV3::CalendarService.new
  end

  class << self
    def instance
      return @instance if @instance

      @instance_mutex.synchronize do
        @instance ||= new
      end
    end
  end

  def create_calendar(calendar)
    @calendar_service.insert_calendar(calendar)

  rescue Google::Apis::ClientError => e
  end

  def delete_calendar(id)
    @calendar_service.delete_calendar(id + "@group.calendar.google.com")

  rescue Google::Apis::ClientError => e
  end

  def set_authorization(client)
    @calendar_service.authorization = client
  end

  def get_calendar_list
    @calendar_service.list_calendar_lists
  end
end
