# frozen_string_literal: true

class Ui::Sale::DetailedReportCreator < Ui::Sale::Report
  def initialize(data)
    @data = data
    @ui = ui
  end

  def ui
    Ui::Sale::DetailedReport.new(@data)
  end

  def get_header
    super(@data)
  end
end
