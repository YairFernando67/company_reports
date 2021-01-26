class Carrier < ApplicationRecord
  enum carrier_type: %i[national international]
  belongs_to :company
  has_one :address, as: :addressable
  has_many :shipment_carriers, class_name: "ShipmentCarrier"
  has_many :shipments, through: :shipment_carriers
  has_one :fiscal_info, as: :fiscal_infoable
  has_many :drivers

  COLUMNS = column_names - %w[id company_id updated_at carrier_type]

  delegate :street, :country, :city, :state, :external_number, to: :address, prefix: "address", allow_nil: true

  scope :national, -> { where(carrier_type: :national) }
  scope :international, -> { where(carrier_type: :international) }
end
