module DesignPatterns
  class FactoryController < ApplicationController
    def index
      @carriers = CarrierService.new(StructureQueue.new).call
    end
  end
end
