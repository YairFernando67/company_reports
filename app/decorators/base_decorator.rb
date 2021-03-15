# frozen_string_literal: true

class BaseDecorator
  class << self
    @@columns = {}

    def decorate(hash, resource=nil)
      new(hash, resource)
    end

    def columns(*attrs)
      @@columns[object_id] = attrs.map(&:to_sym)

      attrs.each do |column|
        define_method(column.to_s) do
          instance_variable_get("@#{column}")
        end
        define_method("#{column}=") do |value|
          instance_variable_set("@#{column}", value)
        end
      end
    end
  end

  def initialize(hash, resource)
    @hash = hash
    @resource = resource
    set_columns
  end

  private

  attr_reader :resource, :hash

  def set_columns
    return unless @@columns[decorator_id]

    @@columns[decorator_id].each do |key|
      send("#{key}=", resource.send(key)) if resource.respond_to?(key)
    end
  end

  def decorator_id
    self.class.object_id
  end
end
