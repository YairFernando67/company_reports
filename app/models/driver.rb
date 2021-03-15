# frozen_string_literal: true

class Driver < ApplicationRecord
  enum status: %i[active suspended limited cancelled denied expired]
  belongs_to :carrier
  has_one :addres, as: :addressable
end
