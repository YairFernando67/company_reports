
module DesignPatterns
  class DecoratorController < ApplicationController
    def index
      @companies = Company.all
      @decorated_company = CompanyService.get_company(params[:company]) if params[:company].present?
    end
  end
end
