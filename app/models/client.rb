class Client < ApplicationRecord
  has_many :purchases, foreign_key: :buyer_id, class_name: "Sale"
  has_one :address, as: :addressable
end
