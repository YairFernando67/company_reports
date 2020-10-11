class Ui::Purchase::SimpleReportCreator < Ui::Purchase::Report

  def initialize(data)
    @data = data
    @ui = ui
  end

  def ui
    Ui::Purchase::SimpleReport.new(@data)
  end
end