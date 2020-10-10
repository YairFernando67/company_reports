class Purchase::Builder
  
  def add_user_info
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
  
  def add_company_info
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
  
  def add_company_fiscal_information
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
end