class Sale < ApplicationRecord
  enum status: [:completed, :rejected, :cancelled] 
  belongs_to :buyer, class_name: "Client"
  belongs_to :seller, class_name: "User"
  belongs_to :company
  has_many :sale_concepts, dependent: :destroy

  # New association
  has_one :shipment

  delegate :name, to: :seller, prefix: "seller", allow_nil: true
  delegate :name, to: :buyer, prefix: "buyer", allow_nil: true
end
