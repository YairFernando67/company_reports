class Companies::BaseDecorator < Companies::BaseInterface
  def initialize(company)
    @company = company
  end

  attr_reader :company
end