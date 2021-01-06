class Carrier < ApplicationRecord
  enum carrier_type: %i[national international]
  belongs_to :company
  has_one :address, as: :addressable
  has_many :shipments, class_name: "ShipmentCarrier"
  has_one :fiscal_info, as: :fiscal_infoable
end
