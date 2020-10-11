class PurchasesController < ApplicationController
  before_action :authenticate_user!

  def generate_report
    @report = PurchaseReportService.new(params, current_user).call
    # @report.get_header
    # binding.pry
    # render json: result
    # binding.pry#e91e63
    # binding.pry
    respond_to do |format|
      format.html
      format.js
      format.pdf do
        render pdf: "Sales Report",
        # javascript_delay: 1000,
        # header: {
        #   html: {
        #     template: 'purchases/header.html.slim',
        #     locals: { user: @report[:user] },
        #   }
        # },
        # show_as_html: true,
        page_size: 'A4',
        # window_status: "FLAG_FOR_PDF",
        template: "purchases/generate_report.html.slim",
        layout: "pdf.html",
        lowquality: true,
        zoom: 1,
        dpi: 75
      end
    end
  end
end
