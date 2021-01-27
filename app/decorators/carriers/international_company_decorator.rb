class Carriers::InternationalCompanyDecorator < Carriers::BaseDecorator
  columns(*Carrier::COLUMNS)

  def address
    carrier.address
  end

  def fiscal_info
    
  end

  def shipments
    
  end

  def drivers
    
  end

  alias carrier resource
end
