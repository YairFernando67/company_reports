class Companies::BaseDecorator < Companies::BaseInterface
  def initialize(object)
    @object = object
  end

  attr_reader :object
end