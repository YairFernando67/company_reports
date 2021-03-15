# frozen_string_literal: true

class Carriers::BaseCarrier
  attr_accessor :carrier

  def initialize(carrier)
    @carrier = carrier
  end

  def fiscal_info
    raise NotImplementedError, "#{self.class} This method has not been implemented yet #{__method__}"
  end

  def shipments
    raise NotImplementedError, "#{self.class} This method has not been implemented yet #{__method__}"
  end

  def dirvers
    raise NotImplementedError, "#{self.class} This method has not been implemented yet #{__method__}"
  end

  def address
    raise NotImplementedError, "#{self.class} This method has not been implemented yet #{__method__}"
  end

  def decorate
    raise NotImplementedError, "#{self.class} This method has not been implemented yet #{__method__}"
  end
end
