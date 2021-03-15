# frozen_string_literal: true

class Carriers::InternationalCarrier < Carriers::BaseCarrier
  def fiscal_info
    fi = carrier.fiscal_info
    {
      fiscal_number: fi.ri,
      account_statement: fi.account_statement,
      since: fi.start_of_operation
    }
  end

  def shipments
    carrier_shipments = carrier.shipments.includes(:client)
    {
      total_shipments: carrier_shipments.size,
      total_products: carrier_shipments.inject(0) { |total, shipment| total += shipment.total_products },
      clients: carrier_shipments.map(&:client_name).uniq
    }
  end

  def drivers
    carrier_drivers = carrier.drivers
    {
      active_drivers: carrier_drivers.active.size,
      drivers: carrier_drivers.map { |d| { name: d.name, email: d.email } },
      total_drivers: carrier_drivers.size
    }
  end

  def address
    [
      carrier.address_street,
      carrier.address_external_number,
      carrier.address_city,
      carrier.address_state,
      carrier.address_country
    ].join(" ")
  end

  def decorate
    Carriers::InternationalCompanyDecorator.decorate(self, carrier)
  end
end
