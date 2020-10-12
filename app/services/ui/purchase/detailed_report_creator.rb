class Ui::Purchase::DetailedReportCreator < Ui::Purchase::Report

  def initialize(data)
    @data = data
    @ui = ui
  end

  def ui
    Ui::Purchase::DetailedReport.new(@data)
  end

  def get_header
    super(@data)
  end
end