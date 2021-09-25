# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: %i[admin employee super_admin]

  has_many :companies, dependent: :destroy
  has_one :address, as: :addressable, dependent: :destroy
  has_many :sales, foreign_key: :seller_id, class_name: "Sale"

  has_many :shipments, inverse_of: :user

  def active_companies
    companies.where(active: true)
  end
end
