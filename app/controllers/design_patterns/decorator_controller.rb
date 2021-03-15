# frozen_string_literal: true

module DesignPatterns
  class DecoratorController < ApplicationController
    def index
      @companies = Company.all
      @decorated_company = CompanyService.get_company(params[:company])
    end
  end
end
