# frozen_string_literal: true

module DesignPatterns
  class BuilderController < ApplicationController
    before_action :authenticate_user!

    def index
      reporter = ReporterService.new(current_user, active_companies)
      @report = SaleReportService.new(params, reporter).call if params[:type].present?
    end

    private

    def active_companies
      current_user.active_companies
    end
  end
end
