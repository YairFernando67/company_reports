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
    return if !self.peek

    self.data.each do |obj|
      yield(obj) if defined?(yield)
    end
  end
end