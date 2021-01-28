module CarriersDecoratorHelper
  def carrier_name
    carrier.carrier.name
  end

  def carrier_email
    carrier.carrier.email
  end

  def carrier_phone
    carrier.carrier.phone
  end
end
