class Company < ApplicationRecord
  belongs_to :user
  belongs_to :company_type
  has_one :address, as: :addressable
  has_many :products, dependent: :destroy
  has_many :sales, foreign_key: :company_id, class_name: "Sale"
  has_one :fiscal_info

  delegate :name, :code, :affiliation, to: :company_type, prefix: "company_type", allow_nil: true
end
