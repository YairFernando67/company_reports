class PurchasesController < ApplicationController
  before_action :authenticate_user!

  def generate_report
    binding.pry
    result = PurchaseReportService.new(params, current_user).call
    render json: :ok
  end
end
