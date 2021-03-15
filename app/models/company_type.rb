# frozen_string_literal: true

class CompanyType < ApplicationRecord
  has_many :companies
end
