# frozen_string_literal: true

class ShipmentCarrier < ApplicationRecord
  belongs_to :carrier
  belongs_to :shipment
end
