# frozen_string_literal: true

class Sales::SimpleReportBuilder < Sales::Builder
  def add_user_info
    reporter.add_user_info
  end

  def add_company_info
    reporter.add_company_info
  end

  def add_sales
    reporter.add_sales
  end

  def add_sale_concepts
    reporter.add_sale_concepts
  end

  def add_charts
    report[:charts] = {}
  end

  # def decorate
  #   Sales::SimpleReportDecorator.decorate(report)
  # end

  attr_accessor :reporter, :user

  private

  def company_fields
    %i[business_name rfc email phone contact]
  end

  def address_fields
    %i[street city state]
  end

  def product_fields
    %i[id name price]
  end

  def fiscal_fields
    %i[]
  end

  def concepts_fields
    %i[id sale_id]
  end

  def employee_fields
    %i[name]
  end

  def client_fields
    %i[name]
  end
end
