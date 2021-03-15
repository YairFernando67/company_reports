# frozen_string_literal: true

class Client < ApplicationRecord
  has_many :purchases, foreign_key: :buyer_id, class_name: "Sale"
  has_many :shipments, through: :purchases
  has_one :address, as: :addressable
end
