class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:admin, :employee, :super_admin]

  has_many :companies, dependent: :destroy
  has_one :address, as: :addressable, dependent: :destroy
  has_many :sales, foreign_key: :seller_id, class_name: "Purchase"
end
