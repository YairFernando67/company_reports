class Carriers::InternationalCompanyDecorator < Carriers::BaseDecorator
  columns(*Carrier::COLUMNS)
  include CarriersDecoratorHelper

  def address
    "
      <div class='int-address'>
        <h3> #{carrier_name&.upcase} </h3>
        <ul>
          <li> Email: #{carrier_email} </li>
          <li> Phone: #{carrier_phone} </li>
          <li> Address: #{carrier.address} </li>
        </ul>
      </div>
    "
  end

  def fiscal_info
    "
      <div class='int-fiscal-info'>
        <strong> Since: <span> #{carrier.fiscal_info[:since]} </span> </strong>
        <strong> Fiscal Number: <span> #{carrier.fiscal_info[:fiscal_number]} </span> </strong>
        <strong> Account Statement: <span> #{carrier.fiscal_info[:account_statement]} </span> </strong>
      </div>
    "
  end

  def shipments
    "
      <div class='int-shipments'>
        <div>
          <h3>Shipments</h3>
          <span>#{carrier.shipments[:total_shipments]} </span>
        </div>
        <div>
          <h3>Products</h3>
          <span>#{carrier.shipments[:total_products]} </span>
        </div>
        <div>
          <h3>Our Clients</h3>
          <span>#{carrier.shipments[:clients].join(" ")} </span>
        </div>
      </div>
    "
  end

  def drivers
    # binding.pry
    "
    <div class='int-drivers'>
      <div class='driver-numbers'>
        <h5>Active Drivers: 
          <span>#{carrier.drivers[:active_drivers]} </span>
        </h5>
        <h5>Total Drivers: 
          <span>#{carrier.drivers[:total_drivers]} </span>
        </h5>
      </div>
      <div class='driver-details'>
        #{get_driver_details.join}
      </div>
    </div>
    "
  end

  alias carrier resource

  private

  def get_driver_details
    carrier.drivers[:drivers].map do |d|
      "
      <div>
        <span>Name: #{d[:name]}</span>
        <span>Email: #{d[:email]}</span>
      </div>
      "
    end
  end
end
