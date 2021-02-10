class Sale::Builder
  def initialize(reporter)
    @user = reporter.user
    @reporter = reporter
    post_initialize
  end

  def post_initialize
    reporter.report = {}
    reporter.set_config(
      address_fields: address_fields,
      company_fields: company_fields,
      product_fields: product_fields,
      fiscal_fields: fiscal_fields
    )
  end

  def report
    reporter.report
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

  def add_employee_info
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def add_client_info
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
end
