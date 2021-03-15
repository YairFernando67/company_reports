# frozen_string_literal: true

class SaleReportService
  def initialize(params, reporter)
    @params = params
    @reporter = reporter
    @director = Sales::Director.new
  end

  def call
    send("get_#{params[:type]}_report")
    report
  end

  private

  def get_simple_report
    builder = Sales::SimpleReportBuilder.new(reporter)
    director.builder = builder
    director.build
  end

  def get_detailed_report
    builder = Sales::DetailedReportBuilder.new(reporter)
    director.builder = builder
    director.build
  end

  def get_full_report
    builder = Sales::FullReportBuilder.new(reporter)
    director.builder = builder
    director.build
  end

  attr_reader :params, :user, :director
  attr_accessor :reporter

  protected

  def report
    reporter.report
  end
end
