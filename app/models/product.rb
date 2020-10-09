class Product < ApplicationRecord
  belongs_to :company
  has_many :purchases, foreign_key: :product_id, class_name: "PurchaseConcept"
end
