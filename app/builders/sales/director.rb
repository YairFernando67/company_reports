class Sales::Director
  attr_accessor :builder

  def initialize
    @builder = nil
  end

  def builder=(builder)
    @builder = builder
  end

  def build
    @builder.add_user_info
    @builder.add_company_info
    @builder.add_sales
    @builder.add_sale_concepts
    @builder.add_charts
    @builder.decorate
  end
end
