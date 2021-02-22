module CarriersDecoratorHelper
  def carrier_shipments
    carrier_hash.shipments
  end

  def carrier_drivers
    carrier_hash.drivers
  end

  def carrier_fiscal_info
    carrier_hash.fiscal_info
  end
end
