class SalesController < ApplicationController
  before_action :authenticate_user!

  def generate_report
    @report = SaleReportService.new(params, current_user).call
    respond_to do |format|
      format.html
      format.js
      format.pdf do
        render pdf: "Sales Report",
        header: {
          html: {
            template: 'sales/header.html.slim',
            locals: { user: @report },
          }
        },
        page_size: 'A4',
        template: "sales/generate_report.html.slim",
        layout: "pdf.html",
        lowquality: true,
        zoom: 1,
        dpi: 75
      end
    end
  end
end
