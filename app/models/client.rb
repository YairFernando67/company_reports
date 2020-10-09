class Client < ApplicationRecord
  has_many :purchases, foreign_key: :buyer_id, class_name: "Purchase"
  has_one :address, as: :addressable
end
