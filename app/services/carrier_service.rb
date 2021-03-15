# frozen_string_literal: true

class CarrierService
  COMPANY_DECORATORS = {
    "national": Carriers::NationalCarrier,
    "international": Carriers::InternationalCarrier
  }.freeze

  class << self
    def call
      carriers.shuffle.map do |c|
        COMPANY_DECORATORS[c.carrier_type.to_sym].new(c).decorate
      end
    end

    private

    def carriers
      Carrier.all
    end
  end
end
