# frozen_string_literal: true

class Shipment < ApplicationRecord
  enum status: %i[completed cancelled pending blocked accepted progress]
  belongs_to :sale
  belongs_to :user
  belongs_to :client
  has_many :shipment_carriers, class_name: "ShipmentCarrier"
  has_many :carriers, through: :shipment_carriers
  has_one :address, as: :addressable

  delegate :name, :email, :phone, to: :client, prefix: "client", allow_nil: true
end
