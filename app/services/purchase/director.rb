class Purchase::Director  
  attr_accessor :builder

  def initialize
    @builder = nil
  end

  def builder=(builder)
    @builder = builder
  end

  def build_simple_report
    @builder.add_user_info
    @builder.add_company_info
    @builder.add_company_fiscal_information
    @builder.add_purchases
    @builder.add_purchase_concepts
    @builder.add_employee_info
    @builder.add_client_info
    @builder.add_charts
  end
end