class PurchaseReportService 
  def initialize(params, user)
    @params = params
    @user = user
    # @director = Purchase::Director.new
  end

  def call
    case @params[:type]
    when "simple" then get_simple_report
    when "detailed" then get_detailed_report
    when "full" then get_full_report
    end
  end

  private

  def get_simple_report
    @director = Purchase::Director.new
    builder = Purchase::SimpleReportBuilder.new(@user)
    @director.builder = builder
    @director.build
    builder.report.data
  end

  def get_detailed_report
    @director = Purchase::Director.new
    builder = Purchase::DetailedReportBuilder.new(@user)
    @director.builder = builder
    @director.build
    builder.report.data
  end

  def get_full_report
    @director = Purchase::Director.new
    builder = Purchase::FullReportBuilder.new(@user)
    @director.builder = builder
    @director.build
    builder.report.data
  end
end