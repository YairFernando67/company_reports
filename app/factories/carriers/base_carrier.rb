class Carriers::BaseCarrier
  def get_carrier
    raise NotImplementedError, "#{self.class} This method has not been implemented yet #{__method__}"
  end

  def address
    carrier = get_carrier
    [
      carrier.address_street, 
      carrier.address_external_number, 
      carrier.address_city, 
      carrier.addres_state, 
      carrier.address_country
    ].join(" ")
  end

  def name
    get_carrier.name
  end

  def phone
    get_carrier.phone
  end

  def email
    get_carrier.email
  end
end