# frozen_string_literal: true

module BuilderHelper
  def user_name
    report[:user][:name]
  end

  def user_email
    report[:user][:email]
  end

  def user_address_street
    report[:user][:street]
  end

  def user_address_city
    report[:user][:city]
  end

  def user_address_state
    report[:user][:state]
  end

  def companies
    report[:companies]
  end
end
