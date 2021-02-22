class Carriers::NationalCarrier < Carriers::BaseCarrier
  def fiscal_info
    fi = carrier.fiscal_info
    {
      fiscal_number: fi.ri,
      account_statement: fi.account_statement,
      proof_of_address: fi.proof_of_address
    }
  end

  def shipments
    carrier_shipments = carrier.shipments.includes(:client)
    {
      total_shipments: carrier_shipments.size,
      total_products: carrier_shipments.inject(0) { |total, shipment| total += shipment.total_products },
      accepted_percentage: (carrier_shipments.accepted.size * 100) / carrier_shipments.size
    }
  end

  def drivers
    carrier_drivers = carrier.drivers
    {
      active_drivers: carrier_drivers.active.size,
      names: carrier_drivers.map(&:name)
    }
  end

  def address
    [
      carrier.address_city,
      carrier.address_state,
      carrier.address_country
    ].join(" ")
  end

  def decorate
    Carriers::NationalCompanyDecorator.decorate(self, self.carrier)
  end

end
