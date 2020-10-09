class Company < ApplicationRecord
  belongs_to :user
  belongs_to :company_type
  has_one :address, as: :addresable
  has_many :products, dependent: :destroy
end
