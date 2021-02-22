class SaleReportService
  def initialize(params, reporter)
    @params = params
    @reporter = reporter
    @director = Sale::Director.new
  end

  def call
    send("get_#{params[:type]}_report")
    report
  end

  private

  def get_simple_report
    builder = Sale::SimpleReportBuilder.new(reporter)
    director.builder = builder
    director.build
  end

  def get_detailed_report
    builder = Sale::DetailedReportBuilder.new(reporter)
    director.builder = builder
    director.build
  end

  def get_full_report
    builder = Sale::FullReportBuilder.new(reporter)
    director.builder = builder
    director.build
  end

  attr_reader :params, :user, :director
  attr_accessor :reporter

  private

  def report
    reporter.report
  end
end
