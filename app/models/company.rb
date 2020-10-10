class Company < ApplicationRecord
  belongs_to :user
  belongs_to :company_type
  has_one :address, as: :addresable
  has_many :products, dependent: :destroy
  has_many :purchases

  delegate :name, :price, to: :products, prefix: "product", allow_nil: true
end
