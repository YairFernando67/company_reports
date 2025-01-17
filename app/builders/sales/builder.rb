# frozen_string_literal: true

class Sales::Builder
  def initialize(reporter)
    @user = reporter.user
    @reporter = reporter
    post_initialize
  end

  def post_initialize
    reporter.set_config(
      address_fields: address_fields,
      company_fields: company_fields,
      product_fields: product_fields,
      fiscal_fields: fiscal_fields,
      concepts_fields: concepts_fields,
      employee_fields: employee_fields,
      client_fields: client_fields
    )
  end

  def report
    reporter.report
  end

  def active_companies
    reporter.active_companies
  end

  def add_user_info
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def add_company_info
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def add_sales
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def add_sales_concepts
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def add_charts
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  private

  def company_fields
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def address_fields
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def product_fields
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def fiscal_fields
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def concepts_fields
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def employee_fields
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def client_fields
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end
