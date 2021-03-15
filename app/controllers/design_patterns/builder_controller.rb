# frozen_string_literal: true

module DesignPatterns
  class BuilderController < ApplicationController
    before_action :authenticate_user!

    def index
      reporter = ReporterService.new(current_user, active_companies)
      @report = SaleReportService.new(params, reporter).call if params[:type].present?
      # binding.pry
      # @company_earnings = @report.ui.data[:charts][:company_earnings]
    end

    def generate_report
      @report = SaleReportService.new(params, current_user).call
      @company_earnings = @report.ui.data[:charts][:company_earnings]
      # binding.pry
      # respond_to do |format|
      #   format.html
      #   format.js
      #   format.pdf do
      #     render pdf: "Sales Report",
      #     header: {
      #       html: {
      #         template: 'design_patterns/builder/header.html.slim',
      #         locals: { user: @report },
      #       }
      #     },
      #     page_size: 'A4',
      #     template: "design_patterns/builder/generate_report.html.slim",
      #     layout: "pdf.html",
      #     lowquality: true,
      #     zoom: 1,
      #     dpi: 75
      #   end
      # end
    end

    private

    def active_companies
      current_user.active_companies
    end
  end
end
