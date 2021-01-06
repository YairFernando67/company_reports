class ShipmentCarrier < ApplicationRecord
  belongs_to :carrier
  belongs_to :shipment
end
