class Ui::Sale::SimpleReportCreator < Ui::Sale::Report

  def initialize(data)
    @data = data
    @ui = ui
  end

  def ui
    Ui::Sale::SimpleReport.new(@data)
  end
  
  def get_header
    super(@data)
  end
end