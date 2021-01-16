class Carriers::InternationalCarrierCreator < Carriers:BaseCarrier
  def get_carrier
    Carriers::InternationalCarrier.new
  end
end