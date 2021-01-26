class Carriers::InternationalCompanyDecorator < Carriers::BaseDecorator
  columns(*Carrier::COLUMNS)

  def address
    "contact info.."
  end

  def fiscal_info
    
  end

  def shipments
    
  end

  def drivers
    
  end

  alias carrier resource
end
