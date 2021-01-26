class Carriers::NationalCompanyDecorator < Carriers::BaseDecorator
  columns(*Carrier::COLUMNS)

  def address
    "national contact info"
  end

  def fiscal_info
    
  end

  def shipments
    
  end

  def drivers
    
  end

  alias carrier resource
end
