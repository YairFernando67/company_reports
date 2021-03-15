# frozen_string_literal: true

class StructureQueue
  include Enumerable
  attr_accessor :data

  def initialize
    @data = []
  end

  def add(value)
    @data.unshift(value)
  end

  def remove
    @data.pop
  end

  def peek
    @data.last
  end

  def each
    return unless peek

    data.each do |obj|
      yield(obj) if defined?(yield)
    end
  end
end
