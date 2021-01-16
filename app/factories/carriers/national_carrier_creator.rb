class Carriers::NationalCarrierCreator < Carriers::BaseCarrier
  def get_carrier
    Carriers::NationalCarrier.new
  end
end