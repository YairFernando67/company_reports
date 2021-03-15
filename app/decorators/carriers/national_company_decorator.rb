# frozen_string_literal: true

class Carriers::NationalCompanyDecorator < BaseDecorator
  columns(*Carrier::COLUMNS)
  include CarriersDecoratorHelper

  def address
    "
      <div class='address'>
        <h5>#{carrier_hash.address}</h5>
        <div class='carrier-details'>
          <span> Name: #{name.upcase} </span>
          <span> Email: #{email} </span>
          <span> Phone: #{phone} </span>
        </div>
      </div>
    "
  end

  def fiscal_info
    "
    <div class='fiscal-info'>
      <small>Fiscal Information</small>
      <blockquote>
        <span> Fiscal Number: <strong>#{carrier_fiscal_info[:fiscal_number].upcase}</strong> </span>
        <span> Account Statement: <strong>#{carrier_fiscal_info[:account_statement]}</strong> </span>
        <span> Proof Of Address: <strong>#{carrier_fiscal_info[:proof_of_address]}</strong> </span>
      </blockquote>
    </div>
    "
  end

  def shipments
    "
      <div class='shipments'>
        <small>Shipments</small>
        <div>
          <h3> Total Shipments: #{carrier_shipments[:total_shipments]}</h3>
          <i class='material-icons right'>present_to_all</i>
        </div>
        <div>
          <h3> Total Products: #{carrier_shipments[:total_products]}</h3>
          <i class='material-icons right'>collections</i>
        </div>
        <div>
          <h3> Accepted Percentage: #{carrier_shipments[:accepted_percentage]}</h3>
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
          <h6>#{carrier_drivers[:names].join(" ")}</h6>
          <h6>Active Drivers <span>##{carrier_drivers[:active_drivers]}</span> </h6>
        </div>
      </div>
    "
  end

  alias carrier_hash hash
  alias carrier resource
end
