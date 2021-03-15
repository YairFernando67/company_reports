# frozen_string_literal: true

class Sales::Director
  attr_accessor :builder

  def initialize
    @builder = nil
  end

  attr_writer :builder

  def build
    @builder.add_user_info
    @builder.add_company_info
    @builder.add_sales
    @builder.add_sale_concepts
    @builder.add_charts
  end
end
