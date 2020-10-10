class PurchasesController < ApplicationController
  before_action :authenticate_user!

  def generate_report
    result = PurchaseReportService.new(params, current_user).call
    render json: result
  end
end
