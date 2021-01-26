class Carriers::BaseDecorator

  class << self
    @@columns = {}

    def decorate(resource)
      new(resource)
    end

    def columns(*attrs)
      @@columns[object_id] = attrs.map(&:to_sym)

      attrs.each do |column|
        
        define_method("#{column}") do
          instance_variable_get("@#{column}")
        end
        define_method("#{column}=") do |value|
          instance_variable_set("@#{column}", value)
        end
      end
    end
  end


  def initialize(resource)
    @resource = resource
    set_columns
  end

  private

  attr_reader :resource

  def set_columns
    return unless @@columns[decorator_id]

    @@columns[decorator_id].each do |key|
      send("#{key}=", carrier_instance.send(key)) if carrier_instance.respond_to?(key)
    end
  end

  def decorator_id
    self.class.object_id
  end

  def carrier_instance
    resource.carrier
  end
end
