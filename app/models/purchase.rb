class Purchase < ApplicationRecord
  enum status: [:completed, :rejected, :cancelled] 
  belongs_to :buyer, class_name: "Client"
  belongs_to :seller, class_name: "User"
  has_many :purchase_concepts, dependent: :destroy
end
