class PurchasesController < ApplicationController
  before_action :authenticate_user!

  def generate_report
    @report = PurchaseReportService.new(params, current_user).call
    respond_to do |format|
      format.html
      format.js
      format.pdf do
        render pdf: "Sales Report",
        header: {
          html: {
            template: 'purchases/header.html.slim',
            locals: { user: @report },
          }
        },
        footer: {
          html: {
            template: 'purchases/footer.html.slim'
          }
        },
        page_size: 'A4',
        template: "purchases/generate_report.html.slim",
        layout: "pdf.html",
        lowquality: true,
        zoom: 1,
        dpi: 75
      end
    end
  end
end
