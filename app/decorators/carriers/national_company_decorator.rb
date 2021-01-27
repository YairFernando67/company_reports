class Carriers::NationalCompanyDecorator < Carriers::BaseDecorator
  columns(*Carrier::COLUMNS)

  def address
    "
      <div class='address'>
        <h5>#{carrier.address}</h5>
        <div class='carrier-details'>
          <span> Name: #{carrier_name&.upcase} </span>
          <span> Email: #{carrier_email} </span>
          <span> Phone: #{carrier_phone} </span>
        </div>
      </div>
    "
  end

  def fiscal_info
    "
    <div class='fiscal-info'>
      <small>Fiscal Information</small>
      <blockquote>
        <span> Fiscal Number: <strong>#{carrier.fiscal_info[:fiscal_number].upcase}</strong> </span>
        <span> Account Statement: <strong>#{carrier.fiscal_info[:account_statement]}</strong> </span>
        <span> Proof Of Address: <strong>#{carrier.fiscal_info[:proof_of_address]}</strong> </span>
      </blockquote>
    </div>
    "
  end

  def shipments
    "
      <div class='shipments'>
        <small>Shipments</small>
        <div>
          <h3> Total Shipments: #{carrier.shipments[:total_shipments]}</h3>
          <i class='material-icons right'>present_to_all</i>
        </div>
        <div>
          <h3> Total Products: #{carrier.shipments[:total_products]}</h3>
          <i class='material-icons right'>collections</i>
        </div>
        <div>
          <h3> Accepted Percentage: #{carrier.shipments[:accepted_percentage]}</h3>
          <i class='material-icons right'>check_box</i>
        </div>
      </div>
    "
  end

  def drivers
    "
      <div class='drivers'> 
        <small>Drivers</small>
        <div>
          <i class='material-icons'>directions_car</i>
          <h6>#{carrier.drivers[:names].join(" ")}</h6>
          <h6>Active Drivers <span>##{carrier.drivers[:active_drivers]}</span> </h6>
        </div>
      </div>
    "
  end

  alias carrier resource

  private

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
