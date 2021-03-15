# frozen_string_literal: true

module DesignPatterns
  class FactoryController < ApplicationController
    def index
      @carriers = CarrierService.call
    end
  end
end
