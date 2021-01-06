class Shipment < ApplicationRecord
  enum status: %i[completed cancelled pending blocked accepted progress]
  # belongs_to :company
  belongs_to :sale
  belongs_to :user
  belongs_to :client
  has_many :carriers, class_name: "ShipmentCarrier"
  has_one :address, as: :addressable
end
