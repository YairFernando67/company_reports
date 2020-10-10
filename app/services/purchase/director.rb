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
    @builder.add_sales
    @builder.add_sale_concepts
    @builder.add_employee_info
    @builder.add_client_info
    @builder.add_charts
  end

  def build_detailed_report
    @builder.add_user_info
    @builder.add_company_info
    @builder.add_company_fiscal_information
    @builder.add_sales
    @builder.add_sale_concepts
    # @builder.show_taxes
    @builder.add_employee_info
    @builder.add_client_info
    @builder.add_charts
  end
end