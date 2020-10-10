class Product < ApplicationRecord
  belongs_to :company
  has_many :purchase_concepts, foreign_key: :product_id, class_name: "PurchaseConcept"
  has_many :purchases, through: :purchase_concepts, source: :purchase
end
