# frozen_string_literal: true

class Sales::SimpleReportDecorator < BaseDecorator
  include BuilderHelper
  def user_info
    "
      <li><strong>Name:</strong> #{user_name} </li>
      <li><strong>Email:</strong> #{user_email} </li>
      <li><strong>Address:</strong> #{user_address_street} #{user_address_city} #{user_address_state} </li>
    "
  end

  def company_information
    # binding.pry
    companies.map do |company|
      "
        <h4>#{company[:business_name]}</h4>
        <div class='details'>
          <span>RFC: <strong> #{company[:rfc]} </strong> </span>
          <span>Email: <strong> #{company[:email]} </strong></span>
          <span>Contact: <strong>#{company[:contact]} </strong></span>
          <span>Phone: <strong> #{company[:phone]} </strong></span>
        </div>
        <div class='products'>
         <h6>Products </h6>
          #{company[:products].map { |p| product_fields(p) }.join}
        </div>
      "
    end.join
  end

  alias report hash

  private

  def product_fields(p)
    "
     <div>
      <span>ID <strong> #{p[:id]} </strong> </span>
      <span>Name <strong> #{p[:name]} </strong></span>
      <span>Price <strong>#{p[:price]} </strong></span>
     </div>
    "
  end
end
