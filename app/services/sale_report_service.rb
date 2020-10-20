class SaleReportService 
  def initialize(params, user)
    @params = params
    @user = user
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
    @director = Sale::Director.new
    builder = Sale::SimpleReportBuilder.new(@user)
    @director.builder = builder
    @director.build
    Ui::Sale::SimpleReportCreator.new(builder.report.data)    
  end

  def get_detailed_report
    @director = Sale::Director.new
    builder = Sale::DetailedReportBuilder.new(@user)
    @director.builder = builder
    @director.build
    Ui::Sale::DetailedReportCreator.new(builder.report.data)    
  end

  def get_full_report
    @director = Sale::Director.new
    builder = Sale::FullReportBuilder.new(@user)
    @director.builder = builder
    @director.build
    Ui::Sale::DetailedReportCreator.new(builder.report.data)    
  end
end