class PurchaseReportService 
  def initialize(params, user)
    @params = params
    @user = user
    @director = Purchase::Director.new
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
    builder = Purchase::SimpleReportBuilder.new(@user)
    @director.builder = builder
    @director.build_simple_report
    builder.report.data
  end

  def get_detailed_report

  end

  def get_full_report

  end
end