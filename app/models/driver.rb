class Driver < ApplicationRecord
  enum status: %i[active suspended limited cancelled denied valid expired]
  belongs_to :carrier
  has_one :addres, as: :addressable
end
