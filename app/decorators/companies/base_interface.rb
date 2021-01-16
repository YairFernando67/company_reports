class Companies::BaseInterface
  def name
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def company_details
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
  
  def company_description
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end