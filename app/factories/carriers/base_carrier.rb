class Carriers::BaseCarrier
  attr_accessor :carrier
  
  def initialize(carrier)
    @carrier = carrier
  end

  def decorate
    raise NotImplementedError, "#{self.class} This method has not been implemented yet #{__method__}"
  end
end
