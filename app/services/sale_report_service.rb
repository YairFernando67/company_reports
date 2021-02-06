class SaleReportService 
  def initialize(params, user)
    @params = params
    @user = user
    @message = "Select a Report!"
  end

  def call
    send("get_#{params[:type]}_report")
  end

  private

  def get_simple_report
    @director = Sale::Director.new
    builder = Sale::SimpleReportBuilder.new(@user)
    @director.builder = builder
    @director.build
    Ui::Sale::SimpleReportCreator.new(builder.report)
  end

  def get_detailed_report
    @director = Sale::Director.new
    builder = Sale::DetailedReportBuilder.new(@user)
    @director.builder = builder
    @director.build
    binding.pry
    Ui::Sale::DetailedReportCreator.new(builder.report)
  end

  def get_full_report
    @director = Sale::Director.new
    builder = Sale::FullReportBuilder.new(@user)
    @director.builder = builder
    @director.build
    Ui::Sale::DetailedReportCreator.new(builder.report)
  end

  attr_reader :message, :params
end
