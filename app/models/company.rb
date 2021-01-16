class Company < ApplicationRecord
  belongs_to :user
  belongs_to :company_type
  has_one :address, as: :addressable
  delegate :street, :country, :city, :state, :external_number, to: :address, prefix: "address", allow_nil: true
  has_many :products, inverse_of: :company, dependent: :destroy
  has_many :sales, foreign_key: :company_id, class_name: "Sale"
  has_many :shipments, through: :sales
  has_one :fiscal_info, as: :fiscal_infoable
  has_many :carriers
  delegate :name, :code, :affiliation, to: :company_type, prefix: "company_type", allow_nil: true
end
