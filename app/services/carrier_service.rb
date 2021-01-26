class CarrierService

  COMPANY_DECORATORS = {
    "national": Carriers::NationalCarrier,
    "international": Carriers::InternationalCarrier
  }

  def initialize(structure)
    @structure = structure
  end

  def call
    # binding.pry
    # carrier.map do |c|
    #   COMPANY_DECORATORS[c.carrier_type].new(c).decorate
    # end
    # @national_carriers = Carrier.national.map { |c| Carriers::NationalCarrier.new(c) }
    # @international_carriers = Carrier.international.map { |c| Carriers::InternationalCarrier.new(c) }

    # append_carriers(national_carriers, international_carriers)
    carriers.map do |c|
      COMPANY_DECORATORS[c.carrier_type.to_sym].new(c).decorate
    end
  end

  private

  def carriers
    Carrier.all
  end

  def append_carriers(national_carriers, international_carriers)
    0.upto(max-1) do |i|
      structure.add(national_carriers[i])
      structure.add(international_carriers[i])
    end

    initialize_decorators
  end

  def initialize_decorators
    structure.map {|d| d.decorate }
  end

  def max
    [national_carriers.size, international_carriers.size].max
  end

  attr_accessor :structure, :national_carriers, :international_carriers
end
