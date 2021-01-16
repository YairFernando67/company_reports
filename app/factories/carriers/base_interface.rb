class Carriers::BaseInterface 
  def fiscal_info
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def shipments
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def drivers
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end